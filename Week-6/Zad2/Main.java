import org.xml.sax.InputSource;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.XMLReaderFactory;
import java.io.IOException;
import java.io.OutputStreamWriter;
import org.xml.sax.Attributes;
import org.xml.sax.ContentHandler;
import org.xml.sax.Locator;
import org.xml.sax.SAXException;
//в rss.xml на един от item елементите съм добавила още един title за да изпробвам всички валидации
public class Main { 
    public static void main(String[] args) {
        OutputStreamWriter outputStreamWriter = new OutputStreamWriter(System.out);
        try {
            XMLReader parser = XMLReaderFactory.createXMLReader();//интерфейс за четене на XML документ с използване на callbacks
            InputSource source = new InputSource("rss.xml");//обектът може да се създаде въз основа на системния идентификатор или резултат върнат от база от данни в случая rss.xml
            parser.setContentHandler(new SAXValidator(outputStreamWriter));//извикваме декларирания клас
            parser.parse(source);//Парсва XML документа 
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                outputStreamWriter.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
//клас който ще валидира xml документа по определените условия
class SAXValidator implements ContentHandler {
    Locator locator;
    OutputStreamWriter outputStreamWriter;
    private String currentElementName;//string който ще приема стойнсот името на current елемента 
    private boolean titleDetected = false;//булева променлива за това дали елементът е от тип title
    private int countOfTitle = 0;//брояч на title елемените
    private boolean linkDetected = false;//булева променлива за това дали елементът е от тип link
    private int countOfLink = 0;//брояч на link елемените
    private boolean descriptionDetected = false;//булева променлива за това дали елементът е от тип description
    private int countOfDescription = 0;//брояч на desctiption елемените
    private boolean itemDetected = false;//булева променлива за това дали елементът е от тип item
    private int countOfItem = 0;//брояч на item елемените

    public SAXValidator(OutputStreamWriter outputStreamWriter) {
        this.outputStreamWriter = outputStreamWriter;
    }

    @Override
    public void setDocumentLocator(Locator locator) {
        this.locator = locator;
    }

    @Override
    public void startDocument() throws SAXException {
        //..
    }

    @Override
    public void endDocument() throws SAXException {
        // ...
    }
    //Функция, която проверява дали стойността на атрибута version (принадлежащ на елемента rss) е цяло положително число
    private void validateVersion(Attributes atts) {
        if (atts.getLength() > 0) {//проверяваме дали атрибутът има зададена стойност
            try {//проверяваме дали елемента, на който принадлежи атрибута rss и дали стойността на атрибута е Integer и по голяма от 0
                if (currentElementName.equals("rss") && (Integer.parseInt(atts.getValue("version")) < 0)) {
                reportError("Attribute version is expected to have a positive integer value: ");//ако числото не е цяло или е отрицателно ще се изведе следното съобщение 
                }
            } catch (NumberFormatException e) {
                reportError(String.format("Wrong value for version: %s (Attribute version is expected to have a positive integer value):", atts.getValue("version")));
            }
        }
    }
    //Функция, която проверява дали броят и видът на поелементите
    @Override
    public void startElement(String uri, String localName, String qName, Attributes atts) throws SAXException {
        currentElementName = qName;//currentElementName приема стойността на пдадното име 
        validateVersion(atts);//проверяват се атрибутите

        if (qName.equals("item")) {//ако елементът е нов item
            //задаваме false за поделементите му и нулираме стойностите на counter-ите
            titleDetected = false;
            linkDetected = false;
            descriptionDetected = false;   
            countOfTitle = 0;
            countOfDescription = 0;
            countOfLink = 0;
            //задаваме стойност true защото елементът е item и увеличаваме броячът на items
            itemDetected = true;
            ++countOfItem;
        }

        if (qName.equals("title")) {
            //задаваме стойност true защото елементът е title и увеличаваме броячът на titles
            titleDetected = true;
            ++countOfTitle;
        }

        if (qName.equals("link")) {
            //задаваме стойност true защото елементът е link и увеличаваме броячът на links
            linkDetected = true;
            ++countOfLink;
        }

        if (qName.equals("description")) {
            //задаваме стойност true защото елементът е description и увеличаваме броячът на descriptions
            descriptionDetected = true;
            ++countOfDescription;
        }
    }
    //Функция, която проерява дали броят на поделементите съвпада с условието
    @Override
    public void endElement(String uri, String localName, String qName) throws SAXException {
        if (localName.equals("item")) {//ако елементът е item и стойностите на броячите на title link и description са различни от 1
            if (!(titleDetected && linkDetected && descriptionDetected && countOfTitle == 1 && countOfLink == 1 && countOfDescription == 1)) {
                reportError("Item must have one subset of the sequence: title, link, description.");//се връща следният error message
            }
        }
        if (localName.equals("channel")) {//ако елементът е channel и стойността на брояча на item не е между 2 и 10
            if (!(itemDetected && countOfItem >= 2 && countOfItem <= 10)) {
                reportError("Number of elements item must be between 2 and 10: ");//се връща следният error message
            }
        }
    }

    @Override
    public void characters(char[] chars, int start, int length) throws SAXException {
        //..
    }


    @Override
    public void startPrefixMapping(String prefix, String uri) throws SAXException {
        // ...
    }

    @Override
    public void endPrefixMapping(String prefix) throws SAXException {
        // ...
    }

    @Override
    public void ignorableWhitespace(char[] chars, int start, int length) throws SAXException {
        // ...
    }

    @Override
    public void processingInstruction(String target, String data) throws SAXException {
        // ...
    }

    @Override
    public void skippedEntity(String name) throws SAXException {
        // ...
    }
    //функция за извеждане на outStream
    private void printIndented(String what) {
        try {
            outputStreamWriter.write(what);
            outputStreamWriter.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    //функция за извеждане на error във определения вид
    private void reportError(String cause) {
        printIndented(String.format("\r\nError: %s on line %d column %d.", cause, locator.getLineNumber(), locator.getColumnNumber()));
    }
}