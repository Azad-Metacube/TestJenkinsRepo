public class PurchaseController {
    
    public String productId{get;set;}
    private String purchaseOrderId;
    public String itemId{get;set;}
    public String SelectedOption{get;set;}
    public String SelectedUserOption{get;set;}
    public String setquantity{get;set;}
    public String setquantity1{get;set;}
    private List<User> userList ;
    public Boolean isAlreadyOrdered{get;set;}
    private String selectedUserId;
    private Map<Id,Products__c> tempProductMap=new Map<Id,Products__c>();
    public Set<Purchase_Order_Line_Item__c> tempLineItemSet = new Set<Purchase_Order_Line_Item__c>();
    
    public List<SelectOption> selectionUserList{
        get {
             List<SelectOption> selectList= new List<SelectOption>();
             selectList.add(new SelectOption('--Select--','--Select--'));
             for(User tempuserList: userList){
                selectList.add(new SelectOption(tempuserList.Id,tempuserList.Name)); 
             }
             return selectList;
        }
        set;
    }
   
    public List<User> userDetail{get;set;}
    
    public List<SelectOption> selectionList{
        get {
             Set<SelectOption> selectSet= new Set<SelectOption>();
             List<SelectOption> selectList= new List<SelectOption>();  
             selectList.add(new SelectOption('Select','--Select--'));
             selectList.add(new SelectOption('All','All'));
             List<Products__c> productCategoryList = tempProductMap.values();
             for(Products__c tempProduct:productCategoryList){
                  if(tempProduct.Category__c != null){
                      selectSet.add(new SelectOption(tempProduct.Category__c,tempProduct.Category__c));
                  }
             }
             selectList.addAll(selectSet);       
             return selectList; 
        }
        set;
    }
    public List<WrapperPurchaseOrderLineItemClass> WrapperPurchaseOrderLineItemClassList {
        get {
            WrapperPurchaseOrderLineItemClassList = new List<WrapperPurchaseOrderLineItemClass>();
            for(Purchase_Order_Line_Item__c p1 : tempLineItemSet) {
                WrapperPurchaseOrderLineItemClassList.add(new WrapperPurchaseOrderLineItemClass(p1));
            }
            return WrapperPurchaseOrderLineItemClassList;
        } 
        set;
    }
   
    public class WrapperPurchaseOrderLineItemClass {
        public Purchase_Order_Line_Item__c p{get;set;}
        
        public WrapperPurchaseOrderLineItemClass(Purchase_Order_Line_Item__c p) {
            this.p= p;
        }
        
        public PageReference saveQuantity() {
            p.Total_Price__c = p.Unit_Price__c  * p.Quantity__c;
            return null;
        }
    }
    
    public PurchaseController(ApexPages.StandardController controller) {
        purchaseOrderId=ApexPages.currentPage().getParameters().get('Id');
        userList = [SELECT Name FROM User LIMIT 10];
        if(purchaseOrderId != null) {            
            List<Purchase_Order__c> purchaseOrder=[Select p.Purchaser__c,p.Status__c From Purchase_Order__c p where p.Id =: purchaseOrderId limit 1];
            if(purchaseOrder[0].Status__c != 'Delivered'){
                if(purchaseOrder[0].Purchaser__c != null){
                    SelectedUserOption = purchaseOrder[0].Purchaser__c;
                }
                List<Purchase_Order_Line_Item__c> tempLineItemList=[Select Id, p.Unit_Price__c, p.Purchase_Order_ID__c, p.Product_ID__c, p.Product_Name__c, p.Quantity__c,p.Total_Price__c  From Purchase_Order_Line_Item__c p where p.Purchase_Order_ID__c =:purchaseOrderId];           
                if((tempLineItemList.size() > 0 && SelectedUserOption != null) || (SelectedUserOption !=null) ){
                    SelectedOption='All';
                }
                for(Purchase_Order_Line_Item__c  temp :  tempLineItemList){
                    tempLineItemSet.add(temp);
                }
                List<Products__c> tempProductList =[Select p.Product_Name__c, p.Unit_Price__c, p.Product_Description__c, p.Product_Code__c, p.Name, p.Id, p.Category__c From Products__c p ];
                for(Products__c tempProduct : tempProductList){
                    tempProductMap.put(tempProduct.Id,tempProduct);         
                 }
             }
             else{
                isAlreadyOrdered = true ;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Order is already delivered'));
             }
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please Select a order'));
        }               
    }
   
     
    public PageReference defineUserDetail(){
        try {
            List<User> userDetailList =[Select u.LastName, u.FirstName,u.Id  From User u where u.Id =: SelectedUserOption limit 1];
            if(userDetailList.size() > 0){
                userDetail = userDetailList;
                updatePurchaser();
            }            
        } catch (Exception e) {
            system.assert(false, e.getStackTraceString());
        }        
        return null;
    }
    
    public List<Products__c> getProductList(){
        List<Products__c> productList;
        String option;
        if(SelectedOption == 'All' || SelectedOption == null){
            option='All';
        }
        else if(SelectedOption == 'Electronics & Communication') {
            option='Electronics & Communication';
        }
        else if(SelectedOption == 'Computer Science') {
            option='Computer Science';
        }
        else if(SelectedOption == 'Mechanical'){
            option='Mechanical';
        }
        else if(SelectedOption == 'Information Technology') {
            option='Information Technology';
       }
       if(option == 'All'){
            productList = tempProductMap.values();
       }
       else{
            productList = new List<Products__c>();
            List<Products__c> tempProductList = tempProductMap.values();
            for(Products__c tempProduct : tempProductList){
                if(tempProduct.Category__c == option ){
                    productList.add(tempProduct);
                }
            }
           
       }
       return productList;  
    }
 
    public void addItem(){
        Products__c tempSelectedProductList=tempProductMap.get(productId);
        Purchase_Order_Line_Item__c tempLineItem= new Purchase_Order_Line_Item__c();
        Boolean flag=false;
        tempLineItem.Product_ID__c = productId;
        tempLineItem.Purchase_Order_ID__c = purchaseOrderId;
        tempLineItem.Unit_Price__c = tempSelectedProductList.Unit_Price__c;
        tempLineItem.Total_Price__c=tempSelectedProductList.Unit_Price__c;
        tempLineItem.Product_Name__c = tempSelectedProductList.Product_Name__c;
        tempLineItem.Quantity__c =1;
        Boolean isProductLineItemAlreadyExists = false;
        for(Purchase_Order_Line_Item__c tempItem : tempLineItemSet){
            if(tempItem.Product_ID__c == tempLineItem.Product_ID__c) {                    
                isProductLineItemAlreadyExists = true;
                break;
            }
        }
        if(!isProductLineItemAlreadyExists){
            tempLineItemSet.add(tempLineItem);
        }                                             
    }
    
    
    public void saveOrder(){
         List<Purchase_Order_Line_Item__c> tempLineItemList= new List<Purchase_Order_Line_Item__c>();
         List<Purchase_Order_Line_Item__c> tempLineItemList2=[Select p.Unit_Price__c, p.Purchase_Order_ID__c, p.Product_ID__c, p.Product_Name__c, p.Quantity__c,p.Total_Price__c  From Purchase_Order_Line_Item__c p where p.Purchase_Order_ID__c =:purchaseOrderId];             
         Set<Purchase_Order_Line_Item__c> tempLineItemSet2= new Set<Purchase_Order_Line_Item__c>();
         tempLineItemSet2.addAll(tempLineItemList2);
         for(Purchase_Order_Line_Item__c tempLineItem : tempLineItemSet)
         if(! tempLineItemSet2.contains(tempLineItem)){
            tempLineItemList.add(tempLineItem);
         }
         System.assert(false, 'tempLineItemList2--' + tempLineItemList2 + 'tempLineItemSet -- ' + tempLineItemSet + 'FINAL tempLineItemList--'+tempLineItemList + 'tempLineItemSet2 -- CHECK' + tempLineItemSet2);
         try{
            upsert  tempLineItemList;
    
        }catch(DMLException e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Item is Already saved to order'));
        }   
    }
    
    public void updatePurchaser() {
        if(SelectedUserOption != null){
                List<Purchase_Order__c> purchaseOrder=new List<Purchase_Order__c>([Select p.Purchaser__c From Purchase_Order__c p where p.Id =: purchaseOrderId limit 1]);
                purchaseOrder[0].Purchaser__c=  SelectedUserOption ;
                try{
                    update purchaseOrder;
                }
                catch(DMLException e){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Selected User doesnot registered'));
                }   
            }
            
    }    
    public void removeProductOrder() {   
        for(Purchase_Order_Line_Item__c p : tempLineItemSet) {
            if(p.Product_ID__c == productId) { 
                tempLineItemSet.remove(p);
                if(p.Id != null) {
                    delete p;
                }
            }
        }   
    }
    public PageReference OrderDetailRedirect(){
         PageReference pg = new PageReference('/apex/OrderDetail?Id='+purchaseOrderId);
            pg.setRedirect(true);
            saveOrder();
            return pg;        
    }
}