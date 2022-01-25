import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamWriter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

public class Main {

    public static void main(String[] args) throws XMLStreamException {

        //Създава изходен поток на файл за запис в посочения файлов дескриптор 
        //Създваме файл ако не съществува такъв с име test.xml
        try(FileOutputStream out = new FileOutputStream("test.xml")){
            writeXml(out);
        } catch (IOException e) {
            e.printStackTrace();//инструмент, използван за обработка на exceptions and errors
        }
    }

    // StAX Cursor API
    private static void writeXml(OutputStream out) throws XMLStreamException {
        //Получаваме метод-фабрика
        XMLOutputFactory output = XMLOutputFactory.newInstance();
        //Създаваме writer за XML
        XMLStreamWriter writer = output.createXMLStreamWriter(out);
        //Задаваме начало на xml документа с version="1.0"
        writer.writeStartDocument("1.0");
        //Root елемента <bookstore>
        writer.writeStartElement("bookstore");
        
        //Създаваме първия book елемент с attribute category със стойност COOKING
        writer.writeStartElement("book");
        writer.writeAttribute("category", "COOKING");
        
        //Създаваме поделемент title със стойност Everyday Italian и с attribute lang със стойност en
        writer.writeStartElement("title");
        writer.writeAttribute("lang", "en");
        writer.writeCharacters("Everyday Italian");
        writer.writeEndElement();//Затваряме елемента title - </title>
        
        //Създаваме поделемент author със стойност Giada De Laurentiis
        writer.writeStartElement("author");
        writer.writeCharacters("Giada De Laurentiis");
        writer.writeEndElement();//Затваряме елемента author - </author>
        
        //Създаваме поделемент year със стойност 2005
        writer.writeStartElement("year");
        writer.writeCharacters("2005");
        writer.writeEndElement();//Затваряме елемента year - </year>
        
        //Създаваме поделемент price със стойност 30.00
        writer.writeStartElement("price");
        writer.writeCharacters("30.00");
        writer.writeEndElement();//Затваряме елемента price - </price>

        writer.writeEndElement();//Затваряме първия book елемент- </book>
        
        //Създаваме втори и трети book елемент по аналогчен начин
        writer.writeStartElement("book");
        writer.writeAttribute("category", "CHILDREN");

        writer.writeStartElement("title");
        writer.writeAttribute("lang", "en");
        writer.writeCharacters("Harry Potter");
        writer.writeEndElement();

        writer.writeStartElement("author");
        writer.writeCharacters("J K. Rowling");
        writer.writeEndElement();

        writer.writeStartElement("year");
        writer.writeCharacters("2005");
        writer.writeEndElement();

        writer.writeStartElement("price");
        writer.writeCharacters("29.99");
        writer.writeEndElement();

        writer.writeEndElement();//Затваряме втория book елемент- </book>

        //Създаваме трети book елемент
        writer.writeStartElement("book");
        writer.writeAttribute("category", "WEB");

        writer.writeStartElement("title");
        writer.writeAttribute("lang", "en");
        writer.writeCharacters("Learning XML");
        writer.writeEndElement();

        writer.writeStartElement("author");
        writer.writeCharacters("Erik T. Ray");
        writer.writeEndElement();

        writer.writeStartElement("year");
        writer.writeCharacters("2003");
        writer.writeEndElement();

        writer.writeStartElement("price");
        writer.writeCharacters("39.95");
        writer.writeEndElement();

        writer.writeEndElement();//Затваряме третия book елемент- </book>

        writer.writeEndDocument();//Затваряме елемента bookstore- </bookstore>

        writer.flush();// flush the writer - изчиства writer от всеки елемент, който може да е вътре в него.

        writer.close();// flush the stream again - затваря всички writer-и включително и скрити
    }
}
