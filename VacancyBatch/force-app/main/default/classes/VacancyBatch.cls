/**
 * Created by OlexandrKrykun on 04.04.2021.
 */

public with sharing class VacancyBatch implements Database.Batchable<SObject> {
  private String batchQuery;
  private String standardQuery = 'Select id from Vacancy__c where status__c = \'closed\' ';

  public VacancyBatch(String query) {
    this.batchQuery = query; 
  }
  public VacancyBatch() {
    this.batchQuery = standardQuery;
  }

  public Database.QueryLocator start(Database.BatchableContext context) {
    return Database.getQueryLocator(this.batchQuery);
  }
  public void execute(
    Database.BatchableContext context,
    List<Vacancy__c> vacancies
  ) {
      List<CronTrigger> CronTrigger = [
              SELECT
                      CreatedById,
                      CreatedDate,
                      CronExpression,
                      CronJobDetail.Name,
                      CronJobDetail.JobType,
                      EndTime,
                      Id,
                      LastModifiedById,
                      NextFireTime,
                      OwnerId,
                      PreviousFireTime,
                      StartTime,
                      State,
                      TimesTriggered,
                      TimeZoneSidKey
              FROM CronTrigger
      ];
      List<AsyncApexJob> apexJobs = [
              SELECT
                      ApexClassId,
                      CompletedDate,
                      CreatedById,
                      CreatedDate,
                      ExtendedStatus,
                      Id,
                      JobItemsProcessed,
                      JobType,
                      LastProcessed,
                      LastProcessedOffset,
                      MethodName,
                      NumberOfErrors,
                      ParentJobId,
                      Status,
                      TotalJobItems
              FROM AsyncApexJob];
      for(CronTrigger cron:CronTrigger){
        System.debug('CronTriggerName->'+ cron.CronJobDetail.Name);
        System.debug('CronTriggerJobType->'+ cron.CronJobDetail.JobType);
      }
      for(AsyncApexJob j:apexJobs){
        System.debug('AsyncApexJob->'+j);
      }
      delete vacancies;
    }
  
  public void finish(Database.BatchableContext context) {
  }



  public class customException extends Exception{}
}
