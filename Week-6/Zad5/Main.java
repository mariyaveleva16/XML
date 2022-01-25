import java.io.File;
import java.io.IOException;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

public class Main {
    public static void main(String[] args) throws ParserConfigurationException, SAXException, IOException, TransformerConfigurationException, TransformerException {
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        dbf.setValidating(false);
        DocumentBuilder builder = dbf.newDocumentBuilder();
        InputSource source = new InputSource("rss.xml");
        Document doc = builder.parse(source);
        process(doc);
        //използваме rss.xml и създаваме нов xml документ rss_new.xml в който ще записваме промененото съдържание
        TransformerFactory tf = TransformerFactory.newInstance();
        Transformer writer = tf.newTransformer();
        writer.setOutputProperty(OutputKeys.ENCODING, "utf-8");
        writer.transform(new DOMSource(doc), new StreamResult(new File("rss_new.xml")));
    }
    
    private static void process(Document doc){
        NodeList linkList = doc.getElementsByTagName("link");//лист с вкички link елементи
        NodeList itemList = doc.getElementsByTagName("item");//лист с всички item елементи
        //i е броят на item елементите и трием последния item елемент докато броят им не стне 10
        for (int i = itemList.getLength() - 1; i >= 10; i--) {
            Element item = (Element) itemList.item(i);
            item.getParentNode().removeChild(item);
        }
        
        for (int i = linkList.getLength() - 1; i >= 0; i--) {
            Element link = (Element) linkList.item(i);//link приема стойностите на всеки елемент от листа
            Element item = (Element) link.getParentNode();//item приема стойностите на всеки prentnode на link елемента
            //проверяваме дали взетия node e item
            if ("item".equals(item.getNodeName())) {
                item.setAttribute("link", link.getTextContent().trim());//ако е му задаваме атрибут със стойност link
                item.removeChild(link);//и трием детето му с име link
            }
        }
        
        Element sponsor = doc.createElement("sponsor");//създаваме елемент sponsor
        sponsor.setTextContent("Sponsor");//със стойност Sponsor
        doc.getElementsByTagName("channel").item(0).appendChild(sponsor);//и го добавяме като дете на елемета channel
    }
}