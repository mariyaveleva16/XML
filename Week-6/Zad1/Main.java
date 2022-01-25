import org.xml.sax.InputSource;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.XMLReaderFactory;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.StringReader;
import org.xml.sax.Attributes;
import org.xml.sax.ContentHandler;
import org.xml.sax.Locator;
import org.xml.sax.SAXException;

public class Main { //replace SAX1 by Main 
    public static void main(String[] args) {
        OutputStreamWriter outputStreamWriter = new OutputStreamWriter(System.out);
        try {
            XMLReader parser = XMLReaderFactory.createXMLReader();//интерфейс за четене на XML документ с използване на callbacks
            InputSource source = new InputSource("rss.xml");//обектът може да се създаде въз основа на системния идентификатор или резултат върнат от база от данни в случая rss.xml
            parser.setContentHandler(new SAXHandler(outputStreamWriter));//Позволява да се регистрира Content Handler
            parser.parse(source);//Парсва XML документа 
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                outputStreamWriter.close();//затваряне на outputStreamWriter
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}

class SAXHandler implements ContentHandler {
    Locator locator;
    Integer indent;
    OutputStreamWriter outputStreamWriter;
    private final Integer TAB_SIZE = 4;

    public SAXHandler(OutputStreamWriter outputStreamWriter) {
        this.outputStreamWriter = outputStreamWriter;
        indent = 0;
    }

    @Override
    public void setDocumentLocator(Locator locator) {
        this.locator = locator;
    }
    //Задаваме начало на output-a със следния текст
    @Override
    public void startDocument() throws SAXException {
        printIndented("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", false, false);
    }

    @Override
    public void endDocument() throws SAXException {
        // ...
    }

    @Override
    public void startElement(String uri, String localName, String qName, Attributes atts) throws SAXException {
        printIndented(String.format("<%s", qName), true, false);//извеждаме началото на всеки елемент във следния формат <име на елемента
        printAttributes(atts);//извеждаме атрибутите му
        printIndented(">\r\n", false, true);//извеждаме > и нов ред
        ++indent;//увеличаваме броя на елементите
    }

    @Override
    public void endElement(String uri, String localName, String qName) throws SAXException {
        --indent;//когато приключи елемент намаляваме броя на използваните елементи
        printIndented(String.format("</%s>", qName), true, false);//извеждаме затварящ таг
    }

    @Override
    public void characters(char[] chars, int start, int length) throws SAXException {//по подаден масив, начало и дължина
        //на нов string s присвояваме масива от подадено начало с подадената дължина и го правим с главни букви като махаме whitespaces с trim()
        String s = new String(chars, start, length).toUpperCase().trim();
        //ако дължината е по-голяма от 0 принтираме стринга
        if (s.length() > 0) {
            printIndented(s, false, false);
        }
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

    private void printIndented(String what, boolean isEndOfElement, boolean isElement) {
        try {
            if(isEndOfElement) {//ако е края на елемента извеждаме нов ред за да бъде всеки елемент на нов ред
                outputStreamWriter.write("\r\n");
            }
            if (indent > 0 && !isElement) {
                outputStreamWriter.write(String.format("%1$" + (indent * TAB_SIZE) + "s", ""));
            }
            outputStreamWriter.write(what);
            outputStreamWriter.flush();// flush the writer - изчиства writer от всеки елемент, който може да е вътре в него
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    //Функция за принтене на атрибути
    private void printAttributes(Attributes atts) {
        if (atts.getLength() > 0) {//ако дължината е по-голяма от 0
            for (int i = 0; i < atts.getLength(); ++i) {//принтим атрибута и неговата стойност на същия ред като елемента на който принадлежат
                printIndented(" " + atts.getQName(i) + "=\"" + atts.getValue(i) + "\"", false, true);
            }
        }
    }
}