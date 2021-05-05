/**
 * Created by OlexandrKrykun on 04.04.2021.
 */

public with sharing class VacancyBatchScheduler implements Schedulable {
    public static final string VACANCY_BATCH_SCHEDULE_JOB = 'VacancyJob';

    public void execute(SchedulableContext SC){
        Database.executeBatch(new VacancyBatch(), 5);
        start();
        //System.abortJob(SC.getTriggerId());
    }

    public static void start(){
        Datetime sysTime = System.now().addSeconds( 20 );
        String chronExpression = '' + sysTime.second() + ' ' + sysTime.minute() + ' ' + sysTime.hour() + ' ' + sysTime.day() + ' ' + sysTime.month() + ' ? ' + sysTime.year();
        System.schedule(VACANCY_BATCH_SCHEDULE_JOB + sysTime, chronExpression, new VacancyBatchScheduler());
        
    }


}