trigger ContractTrigger on Contract (after insert) {
    
    switch on trigger.operationType {
        when AFTER_INSERT {
            ContractTriggerHandler.onAfterInsert(Trigger.new);
        }
    }
}