import java.util.regex.*;
public class JavaBenchmark {
	public static void main(String []args)
	{
		Matcher regex1 = Pattern.compile("^(a|b|c|d|e|f|g)+$").matcher("");
		Matcher regex2 = Pattern.compile("^[a-g]+$").matcher("");
		long timesToDo = 1000;
		
		StringBuffer temp = new StringBuffer();
		for (int i = 1000; i > 0; i--)
			temp.append("abababdedfg");
		String testString = temp.toString();
		
		//第一轮测试计时……
		long count = timesToDo;
		long startTime = System.currentTimeMillis();
		while (--count > 0)
			regex1.reset(testString).find();
		double seconds = (System.currentTimeMillis() - startTime)/1000.0;
		System.out.println("Alternation takes " + seconds + " seconds");

//		//第二轮测试计时……
//		count = timesToDo;
//		startTime = System.currentTimeMillis();
//		while (--count > 0)
//			regex2.reset(testString).find();
//		seconds = (System.currentTimeMillis() - startTime)/1000.0;
//		System.out.println("Character class takes " + seconds + " seconds");
//
	}
}
