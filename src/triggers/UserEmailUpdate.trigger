trigger UserEmailUpdate on Contact (after update) {
    
    Map<Id,User> userMap = new Map<Id,User>();
    for(User tempU : [Select u.Email,u.ContactId from User u where u.ContactId in :trigger.newMap.keySet()]){
        userMap.put(tempU.ContactId , tempU);
    }
    List<User> userEmailListToUpdate = new List<User>();
    for(Contact tempContactList :  trigger.new ){
        User u = userMap.get(tempContactList.Id);
        if(u.Email != tempContactList.Email){
            u.Email = tempContactList.Email;
            userEmailListToUpdate.add(u);
        }
    }
    try{
        update userEmailListToUpdate;
    }catch(DMLException e){
        System.debug(' exception has occurred: ' + e.getMessage());
    }    
}