public class Stack {
	public static List<String> myStack = new List<String>();
	
	public static void push(String Name){
		myStack.add(Name);
	}

	public static String pop(){
		if(isEmpty()){
			system.debug('Stack empty');
		return null;
		}
		else{
			String str=myStack.remove(myStack.size()-1);
			return str;
		}
	}

	public static Boolean isEmpty(){
		if(myStack.size()==0){
			return true;
		}
		return false;
	}

	public static void display(){
		system.debug(myStack);
	}
}

/*Stack.push('a');
Stack.push('b');
Stack.push('c');
Stack.display();
Stack.pop();
Stack.display();
Stack.push('d');
Stack.display();
Stack.pop();
Stack.display();*/