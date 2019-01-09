public  class StudentList {
    public static String myInput{get;set;}
    public static String startDate{get;set;}
    public static String endDate{get;set;}
    public static Integer getWorkingDays {get;set;}
    public static LIST<Schema.SObjectType> allObjectList {get;set;}
    
    public static list<Student__c> getStudentsList() {
        list<Student__c> s =[Select s.First_Name__c,s.Last_Name__c From Student__c s where s.Class__r.Name =:myInput];
        return s;
    }
    
     public void getAllObject() {
         allObjectList = Schema.getGlobalDescribe().values();
    }
    
    public Map<Class__c,List<String>> studentMap1{
        get{
            Map<Class__c,List<String>> studentMap=new Map<Class__c,List<String>>();
            List<Student__c> student=new List<Student__c>();
            List<Class__c> className = new List<Class__c>([Select c.Name From Class__c c ]);
            
            for(Class__c temp: className){
                String cName = temp.Name;
                student=[Select s.Name,s.First_Name__c From Student__c s where s.Class__r.Name =:cName];
                List<String> sName = new List<String>();
                for(Student__c tempStu: student){
                      sName.add(tempStu.First_Name__c);  
                 }
                studentMap.put(temp,sName);
            }
            return studentMap;
            
        }
        set;}
    
    public static void calculateWorkingDays() {
        //system.assert(false, startDate);
        list<Student__c> s1 =[Select s.First_Name__c,s.Last_Name__c,s.CreatedDate From Student__c s];
        System.assert(false,(((System.Now().timeGmt()).hour())*60+((System.Now().timeGmt()).minute())));
        Date startingDate=date.parse(startDate);
        Date endingDate=date.parse(endDate);
           Integer count=0;
           Integer noOfDays = startingDate.daysBetween(endingDate);
           Integer days=date.parse('01/07/1900').daysBetween(startingDate);
           for(Integer i=0 ; i<noOfDays; i++){
               if((math.mod(days+i,7)!=0) && (math.mod(days+i,7)!=6)){
               count++;
               }
            }
           getWorkingDays=count;
    }
    public static void validateclass(){
        Boolean isValidClass = false;
        List<Class__c> classList = new List<Class__c>([Select c.Name from Class__c c]);
        for(Class__c temp:classList)
        {
            if(temp.Name == myInput){
                isValidClass = true;
                break;
            }        
        }      
        
        if(!isValidClass) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Invalid Class Entry'));
        }    
    }
}