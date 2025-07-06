use aarki_proj;
select * from dataset;

update dataset set phonescore = 0 where phonescore is null;
update dataset set Addressscore = 0 where Addressscore is null;

## Adding leadquality coulumn to the table
alter table dataset add column leadquality varchar(20);

## Categorizing Lead Quality
update dataset
set LeadQuality = 
    case 
        when CallStatus IN ('Closed', 'EP Sent', 'EP Received', 'EP Confirmed') then 'Good'
        when CallStatus IN ('Unable to contact - Bad Contact Information', 'Contacted - Invalid Profile', "Contacted - Doesn't Qualify") then 'Bad'
        else 'Unknown'
    end;
select leadquality from dataset;

## Calculating Lead Quality Trends Over Time
select
    date_format(`LeadCreated`, '%Y-%m') AS MonthYear,
    count(*) AS TotalLeads,
    sum(case when LeadQuality = 'Good' then 1 else 0 end) as GoodLeads,
	sum(case when LeadQuality = 'Bad' then 1 else 0 end) as BadLeads,
    sum(case when LeadQuality = 'Unknown' then 1 else 0 end) as UnknownLeads,
    (sum(case when LeadQuality = 'Good' then 1 else 0 end) / count(*)) * 100 as LeadQualityRate
from dataset
group by MonthYear
order by MonthYear;

## Analyzing the Effect of Different Factors
# Based on Adtpye
SELECT 
    WidgetName,
    COUNT(*) AS TotalLeads,
    SUM(CASE WHEN LeadQuality = 'Good' THEN 1 ELSE 0 END) AS GoodLeads,
    SUM(CASE WHEN LeadQuality = 'Bad' THEN 1 ELSE 0 END) AS BadLeads,
    (SUM(CASE WHEN LeadQuality = 'Good' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS LeadQualityRate
FROM dataset
GROUP BY WidgetName
ORDER BY GoodLeadRate DESC;

# Based on Ad Placement
SELECT 
    PublisherZoneName,
    COUNT(*) AS TotalLeads,
    SUM(CASE WHEN LeadQuality = 'Good' THEN 1 ELSE 0 END) AS GoodLeads,
    SUM(CASE WHEN LeadQuality = 'Bad' THEN 1 ELSE 0 END) AS BadLeads,
    (SUM(CASE WHEN LeadQuality = 'Good' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS LeadQualityRate
FROM dataset
GROUP BY PublisherZoneName
ORDER BY GoodLeadRate DESC;

# Baesd on lead source
SELECT 
    PublisherCampaignName,
    COUNT(*) AS TotalLeads,
    SUM(CASE WHEN LeadQuality = 'Good' THEN 1 ELSE 0 END) AS GoodLeads,
    SUM(CASE WHEN LeadQuality = 'Bad' THEN 1 ELSE 0 END) AS BadLeads,
    (SUM(CASE WHEN LeadQuality = 'Good' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS LeadQualityRate
FROM dataset
GROUP BY PublisherCampaignName
ORDER BY GoodLeadRate DESC;

# Based on Brand
SELECT 
    AdvertiserCampaignName,
    COUNT(*) AS TotalLeads,
    SUM(CASE WHEN LeadQuality = 'Good' THEN 1 ELSE 0 END) AS GoodLeads,
    SUM(CASE WHEN LeadQuality = 'Bad' THEN 1 ELSE 0 END) AS BadLeads,
    (SUM(CASE WHEN LeadQuality = 'Good' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS LeadQualityRate
FROM dataset
GROUP BY AdvertiserCampaignName
ORDER BY GoodLeadRate DESC;

# Based on Debt-Level
SELECT 
    DebtLevel,
    COUNT(*) AS TotalLeads,
    SUM(CASE WHEN LeadQuality = 'Good' THEN 1 ELSE 0 END) AS GoodLeads,
    SUM(CASE WHEN LeadQuality = 'Bad' THEN 1 ELSE 0 END) AS BadLeads,
    (SUM(CASE WHEN LeadQuality = 'Good' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS LeadQualityRate
FROM dataset
GROUP BY DebtLevel
ORDER BY GoodLeadRate DESC;

# Based on Address score and Phonescore
SELECT 
    AddressScore,
    PhoneScore,
    COUNT(*) AS TotalLeads,
    SUM(CASE WHEN LeadQuality = 'Good' THEN 1 ELSE 0 END) AS GoodLeads,
    SUM(CASE WHEN LeadQuality = 'Bad' THEN 1 ELSE 0 END) AS BadLeads,
    (SUM(CASE WHEN LeadQuality = 'Good' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS LeadQualityRate
FROM dataset
GROUP BY AddressScore, PhoneScore
ORDER BY GoodLeadRate DESC;

# Based on partner 
SELECT 
    Partner,
    COUNT(*) AS TotalLeads,
    SUM(CASE WHEN LeadQuality = 'Good' THEN 1 ELSE 0 END) AS GoodLeads,
    SUM(CASE WHEN LeadQuality = 'Bad' THEN 1 ELSE 0 END) AS BadLeads,
    (SUM(CASE WHEN LeadQuality = 'Good' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS LeadQualityRate
FROM dataset
GROUP BY Partner
ORDER BY GoodLeadRate DESC;










