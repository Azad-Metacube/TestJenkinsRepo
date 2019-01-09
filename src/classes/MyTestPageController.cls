public class MyTestPageController {

    public Student__c studentDetail { get; set; }
    
    public List<schema.fieldsetmember> fields {
    get {
        return getFields('Student__c','Student_Detail');
    } set; }

    public List<schema.fieldsetmember> getFields(String objectName, String fieldSetName) {
        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(objectName);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();            
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName);
        return fieldSetObj.getFields();
    }
    
    public MyTestPageController(){
        this.studentDetail = populateStudentDetail();
    }
    
    private Student__c populateStudentDetail(){
        String query = 'SELECT ';
        for(Schema.FieldSetMember f : fields ) {
            query += f.getFieldPath() + ', ';
        }
        query = query.subString(0, query.length() - 2);
        query += ' FROM Student__c LIMIT 1';
        return Database.query(query);
    }

}