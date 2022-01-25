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

public class Main {
    public static void main(String[] args) {
        OutputStreamWriter outputStreamWriter = new OutputStreamWriter(System.out);
        try {
            XMLReader parser = XMLReaderFactory.createXMLReader();//интерфейс за четене на XML документ с използване на callbacks
            InputSource source = new InputSource("rss.xml");//четем от файла
            parser.setContentHandler(new SAXTransformator(outputStreamWriter));//извикваме класа
            parser.parse(source);
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
//клас, който ще ни трансформира xml докмента 
class SAXTransformator implements ContentHandler {
    private class Item {//клас с поделементите на item
        String title;
        String link;
        String description;
    }

    Locator locator;
    OutputStreamWriter outputStreamWriter;
    private final Integer TAB_SIZE = 4;
    private String currentElement;//име н елемета,в който сме
    private Integer indent;//за брой табулации за оформяне на изходния вид на документа
    private Item currentItem;//брояч на item-и
    boolean inItem = false;//булева променлива,която ще зависи от това дали елементът е item

    public SAXTransformator(OutputStreamWriter outputStreamWriter) {
        this.outputStreamWriter = outputStreamWriter;
    }

    @Override
    public void setDocumentLocator(Locator locator) {
        this.locator = locator;
        indent = 0;
    }
    //задаване на форматиране на изходния файл(старт на докмента)
    @Override
    public void startDocument() throws SAXException {
        printIndented("<!DOCTYPE html>");
        printIndented("<html>");
        ++indent;
        printIndented("<head><title>List of items</title></head>");
        printIndented("<body>");
        ++indent;
        printIndented("<table style=\"border: 2px solid black;\">");
        ++indent;
        printIndented("<thead><tr><th>Title</th><th>Link</th><th>Description</th></tr></thead>");
        printIndented("<tbody>");
        ++indent;
    }
    //затварящи тагове и намаляваме броя на табовете
    @Override
    public void endDocument() throws SAXException {
        --indent;
        printIndented("</tbody>");
        --indent;
        printIndented("</table>");
        --indent;
        printIndented("</body>");
        --indent;
        printIndented("</html>");
    }

    @Override
    public void startElement(String uri, String localName, String qName, Attributes atts) throws SAXException {
        currentElement = qName;

        if ("item".equals(currentElement)) {//ако елементът е нов Item
            currentItem = new Item();//задаваме нов брояч
            inItem = true;//и булевата стойност става true
        }
    }
    //функция за извеждане на съдържанието на поделементите на item
    @Override
    public void endElement(String uri, String localName, String qName) throws SAXException {
        if ("item".equals(localName)) {//извежаме поделементите на item-a в който сме в следния формат
            printIndented("<tr><td>" + currentItem.title + "</td><td>" + currentItem.link + "</td><td>" + currentItem.description + "</td></tr>");
            inItem = false;//и булевата стойност става false защото елементът приключва
        }
    }

    @Override
    public void characters(char[] chars, int start, int length) throws SAXException {
        String s = new String(chars, start, length).trim();//на променливата s присвояваме нов стринг от char с пределени начало и дължина

        if (inItem && s.length() > 0) {//докато сме в item елемена и сължината на s е по-голяма от 0 присвояваме дадените сойности в зависимост от името на елемента
            if ("title".equals(currentElement)) {
                currentItem.title = s;
            }
            if ("link".equals(currentElement)) {
                currentItem.link = s;
            }
            if ("description".equals(currentElement)) {
                if(currentItem.description == null) {
                currentItem.description = s;
                } else {
                currentItem.description += s;
                }
            }
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
    //функция за извеждане на съдържанието в дадения формат
    private void printIndented(String what) {
        try {
            if (indent > 0) {
                outputStreamWriter.write(String.format("%1$" + (indent * TAB_SIZE) + "s", ""));
            }
            outputStreamWriter.write(what + "\r\n");
            outputStreamWriter.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}