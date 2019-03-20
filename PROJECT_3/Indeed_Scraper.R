---
  title: "Indeed Scraper"
Author: "OMER OZEREN"
output: html_notebook
---
  
  
  
  ## Load the libraries:
  
library(rvest)
library(RCurl)


cities <- c("New+York+NY", "Seattle+WA", "San+Francisco+CA",
            "Washington+DC","Atlanta+GA","Boston+MA", "Austin+TX",
            "Los+Angeles+CA")
target.job <- "data+scientist"   
base.url <- "https://www.indeed.com/"
max.results <- 100

#create a df to hold everything that we collect
jobs.data <- data.frame(matrix(ncol = 4, nrow = 0))
n <- c("city","job.title","company.name","description")
colnames(jobs.data)<-n



#Havesting data for all the cities and begin to parse the results with xpaths to extract interesting information 
for (city in cities){
  print(paste("Downloading data for: ", city))
  
  
  for (start in range(0,max.results,10)){
    
    url <- paste(base.url,"jobs?q=",target.job,"&l=",city,"&start=", start ,sep="")
    page <- read_html(url)
    Sys.sleep(1)
    
    
    
    #get the links
    links <- page %>% 
      html_nodes("div") %>%
      html_nodes(xpath = '//*[@data-tn-element="jobTitle"]') %>%
      html_attr("href")
    
    
    #get the job title
    job.title <- page %>% 
      html_nodes("div") %>%
      html_nodes(xpath = '//*[@data-tn-element="jobTitle"]') %>%
      html_attr("title")
    
    #get the job title
    job.title <- page %>% 
      html_nodes("div") %>%
      html_nodes(xpath = '//*[@data-tn-element="jobTitle"]') %>%
      html_attr("title")
    
    #get the company name
    company.name <- page %>% 
      html_nodes("span")  %>% 
      html_nodes(xpath = '//*[@class="company"]')  %>% 
      html_text() %>%
      trimws -> company.name 
    
    
    #get the description
    description <- page %>% 
      html_nodes("span")  %>% 
      html_nodes(xpath = '//*[@class="summary"]')  %>% 
      html_text() %>%
      trimws -> description
    
  }
  

  
  #fill in the job data
  job.city <- rep(city,length(links))
  

  
  #iterate over the links that we collected
  for ( n in 1:length(links) ){
    
    #build the link
    link <- paste(base.url,links[n],sep="")
    
    #pull the link
    page <- read_html(link)
    

    
  }
  
  #add the newly collected data to the jobs.data
  jobs.data <- rbind(jobs.data,data.frame(city,
                                          job.title,
                                          company.name,
                                          description))
  
  
}

write.csv(jobs.data, file = "C:/Users/OMERO/Documents/GitHub/Data607/PROJECT_3/Indeed_Job_Search.csv")
