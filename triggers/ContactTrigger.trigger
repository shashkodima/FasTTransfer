trigger ContactTrigger on Contact (after insert) {
    
    switch on trigger.operationType {
        when AFTER_INSERT {
            ContactTriggerHandler.onAfterInsert(Trigger.newMap);
        }
    }
}