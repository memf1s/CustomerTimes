trigger logger_frameworkTrigger on 	logger_framework__e (after insert) {
    for (logger_framework__e event : Trigger.New) {

        System.debug('i am here14');
        Map<String, Object> eventPayloadMap = (Map<String, Object>) JSON.deserializeUntyped(event.payload__c);
        String logLevel = (String) eventPayloadMap.get('LogLevel');

        if (logLevel == 'ERROR') {

            Exception ex = (Exception) eventPayloadMap.get('Exception');
            Database.BatchableContext context = (Database.BatchableContext) eventPayloadMap.get('Context');
            Logger.Log(context, ex, logLevel);

        } else if (logLevel == 'INFO') {

            String message = (String) eventPayloadMap.get('Message');
            Logger.Log(logLevel, message);

        }
   }
}