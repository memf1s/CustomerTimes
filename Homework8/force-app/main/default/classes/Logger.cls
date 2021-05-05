public with sharing class Logger {
    public static void Log(String logLevel,String Message) {
        Log__c logRecord = new Log__c();
        logRecord.Logging_lavel__c = logLevel;
        logRecord.Message__c = Message;
        insert logRecord;
    }
    public static void Log(Database.BatchableContext context, Exception ex, String logLevel) {
        Log__c logRecord = new Log__c();
        logRecord.Context_Id__c = context.getJobId();
        List<CronJobDetail> v1 = [SELECT Name from CronJobDetail where Id = :context.getJobId() limit 1];
        logRecord.Context_Name__c = v1[0].Name;
        logRecord.Message__c = ex.getMessage();
        logRecord.Stack_trace_String__c = ex.getStackTraceString();
        logRecord.Logging_lavel__c = logLevel;
        insert logRecord;
    }
}