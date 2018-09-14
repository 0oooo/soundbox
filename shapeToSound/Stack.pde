class Stack<T> {
  
  private ArrayList<T> stack;
  
  public Stack() {
    this.stack = new ArrayList<T>();
  }
  
  public void push(T element) {
    this.stack.add(0, element);
  }
  
  public T pop() {
    if(this.stack.isEmpty()) {
       return null; 
    }
    
    T element = this.stack.get(0); 
    this.stack.remove(0);
    
    return element; 
  } 
  
  public T peak(){
    return this.stack.get(0);
  }
  
  public int size() {
    return this.stack.size(); 
  }
  
  public boolean isEmpty() {
     return this.stack.size() == 0; 
  }
}
