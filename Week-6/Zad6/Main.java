import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamConstants;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;

public class Main {
    public static void main(String[] args) {
        XMLInputFactory xmlif = XMLInputFactory.newInstance();
        XMLStreamReader xmlr = null;
        try {//четем от файла rss.xml
            xmlr = xmlif.createXMLStreamReader(new FileReader("rss.xml"));
            while(xmlr.hasNext()){//докато има следващ елемент принтим настоящия и взимаме следващия
                printEvent(xmlr);
                xmlr.next();
            }
            xmlr.close();//след прочитането затваряме
        } catch (FileNotFoundException ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        } catch (XMLStreamException ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private static void printEvent(XMLStreamReader xmlr){
        switch(xmlr.getEventType()){//за всяка различна част от четеия файл си създаваме случай
            case XMLStreamConstants.START_DOCUMENT: {//извеждаме началото на документа - <?xml version="1.0" encoding="UTF-8"?>
                System.out.print("<?xml version=\"" + xmlr.getVersion() + "\" encoding=\""+ xmlr.getCharacterEncodingScheme() + "\"?>\n");
                break;
            }
            case XMLStreamConstants.START_ELEMENT: {//за всеки отварящ таг на елемент
                System.out.print("<");//извеждаме <
                printName(xmlr);//извикваме функцията която връща името на елемента
                printAttributes(xmlr);//извикваме функцията която връща неговите атрибути 
                System.out.print(">");//извеждаме >
                break;
            }
            case XMLStreamConstants.CHARACTERS: {//съдържание на всеки елемент
                int start = xmlr.getTextStart();//началото
                int length = xmlr.getTextLength();//дължината
                System.out.print(new String(xmlr.getTextCharacters(), start, length).toUpperCase());//извеждаме съдържанието с главни букви
                break;
            }
            case XMLStreamConstants.END_ELEMENT: {//затварящ таг на всеки елемент
                System.out.print("</");//извеждаме </
                printName(xmlr);//извикваме функцията която връща името на елемента
                System.out.println(">");//извеждаме >
                break;
            }
        }      
    }
    
    private static void printName(XMLStreamReader xmlr){
        if (xmlr.hasName()) {
            //присвояваме на string-ове всики необходими стойностти за извеждане
            String prefix = xmlr.getPrefix();
            String uri = xmlr.getNamespaceURI();
            String localName = xmlr.getLocalName();
            printName(prefix, uri, localName);//извеждаме името на елемента
        }
    }
    
    private static void printName(String prefix, String uri, String localName){
        if (uri != null && !("".equals(uri))) {
            System.out.print("['" + uri + "']");//ако имаме uri и той не е "" го изведаме в следния формат
        }
        if (prefix != null && prefix.length() > 0) {
            System.out.print(prefix + ":");//ако имаме prefix и дължината му е по-голяма от 0 го извеждаме следван от :
        }
        if (localName != null) {
            System.out.print(localName);//ако имаме localName го извеждаме
        }
    }
    
    private static void printAttributes(XMLStreamReader xmlr){
        //Ако елемент има повече от 1 атрибут да се извдат всички
        //ако е само 1 ще се изведе той и цикълът ще приключи 
        for (int i = 0; i < xmlr.getAttributeCount(); i++) {
            printAttribute(xmlr, i);
        }
    }
    
    private static void printAttribute(XMLStreamReader xmlr, int index){
        //функция за извеждане на атибутите на елемент
        //визмаме всички необходими части на атрибута по подаден индекс
        String prefix = xmlr.getAttributePrefix(index);
        String namespace = xmlr.getAttributeNamespace(index);
        String localName = xmlr.getAttributeLocalName(index);
        String value = xmlr.getAttributeValue(index);
        System.out.print(" ");//интервал пред името на атрибута за да не се долепя до името на елемента
        printName(prefix, namespace, localName);
        System.out.print("=\"" + value + "\"");//извеждат се името на атрибута="неговата стойност"
    }
}