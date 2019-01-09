public class OrderDetailController {
	private String purchaseOrderId;
	
	public Decimal totalPrice{get;set;}
	
	public List<Purchase_Order_Line_Item__c> orderedLineItemList{get;set;}
	
    public OrderDetailController(ApexPages.StandardController controller) {
		purchaseOrderId=ApexPages.currentPage().getParameters().get('Id');
		if(purchaseOrderId != null){
			totalPrice=0;
			orderedLineItemList=[Select p.Quantity__c,p.Total_Price__c, p.Product_ID__r.Product_Name__c, p.Name,p.TotalItemPrice__c,p.Unit_Price__c From Purchase_Order_Line_Item__c p  where p.Purchase_Order_ID__c =:purchaseOrderId];
			for(Purchase_Order_Line_Item__c temporderedItem :orderedLineItemList){
				totalPrice=totalPrice+temporderedItem.TotalItemPrice__c;
			}
		}else{
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please First select Items For Order'));
		}	
    }
    public void updateStatus(){
    	Purchase_Order__c purchaseOrder=[Select p.Status__c,p.Total_Price__c,Purchase_Date__c From Purchase_Order__c p where p.Id =: purchaseOrderId limit 1];
			purchaseOrder.Status__c='Delivered';
			purchaseOrder.Total_Price__c=totalPrice;
			purchaseOrder.Purchase_Date__c=system.today();
			try{
				update purchaseOrder;
			}
			catch(DMLException e){
				 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Unable to update Status'+e.getMessage()));
			}
    }
    public PageReference newOrderRedirect(){
    	return new PageReference('/a04/e?retURL=%2Fa04%2Fo');
    }
	
}