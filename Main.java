import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Attr;
import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

public class Main {
    private static boolean skipNL;
    private static Document doc; //За да ни бъде достъпен документа в целия клас

    public static void main(String[] args) throws Exception {
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        dbf.setValidating(false);
        DocumentBuilder builder = dbf.newDocumentBuilder();
        InputSource source = new InputSource("rss.xml"); 
        //Ще четем от rss.xml и ще извеждаме на конзолата 
        doc = builder.parse(source);
        System.out.println(printXML(doc.getDocumentElement()));
    }

    private static String printXML(Node rootNode) {
        skipNL = false;
        return (printOutXML(rootNode));//връжаме функцията printOutXML с елемент rootNode
    }
    //Извеждане на xml документа
    private static String printOutXML(Node rootNode) {
        String print = "";//създаваме си празен string print в който ще запазваме съдържанието на xml докумнета в определения вид
        if (rootNode.getNodeType() == Node.ELEMENT_NODE) {
            print += "<" + rootNode.getNodeName().trim();//добавяме < и името на елемента
            NamedNodeMap attributes = rootNode.getAttributes();//взимаме атрибутите
            for (int j = 0; j < attributes.getLength(); j++) {
                Attr attr = (Attr) attributes.item(j);
                if (attr != null) {//проверяваме дали елемена има атрибути
                    //ако има ги добавяме в изходния текст
                    print += String.format(" %s='%s'", attr.getNodeName(), attr.getNodeValue());
                }
            }
            print += ">";//прибавяме и > за край на отварящия таг на елемента
        }
        NodeList nl = rootNode.getChildNodes();//запазваме децата на root елемента
        if (nl.getLength() > 0) {
            //Добавяме рекурсивно съдържанието на всеки поделемент на текущия елемент
            for (int i = 0; i < nl.getLength(); i++) {
                print += printOutXML(nl.item(i));
            }
        } else {
            if (rootNode.getNodeValue() != null) {
                //Съдържанието трябва да е с главни букви
                print = rootNode.getNodeValue().toUpperCase();
            }
            skipNL = true;
        }
        if (rootNode.getNodeType() == Node.ELEMENT_NODE) {
            if (!skipNL) {
                print += "\n";//след края на всеки елемент извеждам нов ред
            }
            skipNL = false;
            // Слагаме затварящ таг за текущия елемент.
            print += "</" + rootNode.getNodeName() + ">";//когато елементът приключи слагаме и затварящия му таг във вида </име на елемент>
        }
        return (print);//извеждаме всичко запазено в print
    }
}