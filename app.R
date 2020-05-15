library(shiny)

ncheck <- 47 # Number of checklist items CHANGE to 47
checkIDs <- c("1", "2","3","4",
              "5", "6", "7a.Data_Sources", "7b.Data_Available", "7c.Code_Available", "8", "9", "10","11", "12", "13", "14", 
              "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", 
              "25","26", "27", "28", "29", "30", "31", "32", 
              "33", "34", "35a.Performance", "35b.Benchmark", "36","37",
              "38a.Summary", "38b.Limitations", "39",  
              "40a.Datacollection_Registered", "40b.Analysis_Registered", "41", "42"
)

# Vectors of checklist IDs
inputIDs <- paste0("checklist", checkIDs)  # Generate inputIDs
newIDs <- paste0("new", checkIDs)  # Generate newIDs
textIDs <- paste0("text", checkIDs)  # Generate textIDs
summaryIDs <- paste0("summary", checkIDs)  # Generate summaryIDs
sumIDs <- paste0("sum", checkIDs)
responseIDs <- paste0("response", checkIDs)

# Vector of indeces for pre-existing choices in "choicelist" - 47 items
choiceindex <- c(6,6,1,3, # items 1-4
                4,1,1,1,1,5,1,2,2,2,2,2, # METHODS: checklist items 5-14, including new subcategory 7a-c repository to data/code
                2,2,2,2,1,2,2,1,1,1, # items 15-24, including 
                2,2,2,1,1,1,2,1, # items 25-32 
                5,5,1,1,2,2, # RESULTS: checklist items 33-37, including new subcategory 35a-b model performance/benchmark
                5,5,1,  # DISCUSSION: checklist items 38 and 39, including new subcategory 38a-b summary/limitations
                1,1,2,1 # OTHER INFOCMATION: checklist items 40-42, including new subcategory 40a-b registration of data generating process/ML study
)

# "choicelist" contains outcome space, i.e. all possible combination of choices that are used to build choice selections for individual items
# adapt where needed! 
choicelist <- list(c("No", "Yes"),
                   c("No", "Yes", "Not applicable"),
                   c("Objectives: No; Hypotheses: No", "Objectives: No; Hypotheses: Yes", "Objectives: Yes; Hypotheses: No", "Objectives: Yes; Hypotheses: Yes"),
                   c("Please Select","Retrospective", "Prospective"),
                   c("No", "Partially", "Yes"), 
                   c("no", "yes") # used for items where open text is not needed. 
)

# can be later refined, e.g. c("No", "Yes", "Not applicable, the study does not take cognitive or behavioural measures")


# Text vectors
labels <- c("1) Identification as a study of AI methodology, specifying the category of technology used (eg, deep learning) in title or abstract.",
            "2) Structured summary of study design, methods, results, and conclusions.",
            "3) Scientific and clinical background, including the intended use and clinical role of the AI approach",
            "4) Study objectives and hypotheses.",
            "5) Prospective or retrospective study.",
            "6) Study goal, such as model creation, exploratory study, feasibility study, noninferiority trial.",
            "7a) Data sources.",
            "7b) Data deposited." , 
            "7c) Software/code deposited.",
            "8) Eligibility criteria: how, where, and when potentially eligible participants or studies were identified (eg, symptoms, results from previous tests, 
            inclusion in registry, patient-care setting, location, dates).",
            "9) Data preprocessing steps.",
            "10) Selection of data subsets, if applicable.",
            "11) Definitions of data elements, with references to common data elements.",
            "12) De-identification methods.",
            "13) How missing data were handled.",
            "14) Definition of ground truth reference standard, in sufficient detail to allow replication.",
            "15) Rationale for choosing the reference standard (if alternatives exist).",
            "16) Source of ground truth annotations; qualifications and preparation of annotators.", 
            "17) Annotation tools.",
            "18) Measurement of inter- and intrarater variability; methods to mitigate variability and/or resolve discrepancies.",
            "19) Intended sample size and how it was determined.",
            "20) How data were assigned to partitions; specify proportions.",
            "21) Level at which partitions are disjoint (eg, image, study, patient, institution)",
            "22) Detailed description of model, including inputs, outputs, all intermediate layers and connections.", 
            "23) Software libraries, frameworks, and packages.", 
            "24) Initialization of model parameters (eg, randomization, transfer learning).", 
            "25) Details of training approach, including data augmentation, hyperparameters, number of models trained.", 
            "26) Method of selecting the final model.", 
            "27) Ensembling techniques, if applicable.", 
            "28) Metrics of model performance.", 
            "29) Statistical measures of significance or model evidence and uncertainty (eg, confidence or credible intervals).", 
            "30) Robustness or sensitivity analysis.", 
            "31) Methods for explainability or interpretability (eg, saliency maps) and how they were validated.", 
            "32) Validation or testing on external data.", 
            "33) Flow of participants or cases, using a diagram to indicate inclusion and exclusion.", 
            "34) Demographic and clinical characteristics of cases in each partition.", 
            "35a) Performance metrics for optimal model(s) on all data partitions", 
            "35b) Benchmark performance against current standards.", 
            "36) Estimates of diagnostic accuracy and their precision (such as 95% confidence intervals).", 
            "37) Failure analysis of incorrectly classified cases.", 
            "38a) Summary of results.",  
            "38b) Study limitations, including potential bias, statistical uncertainty, and generalizability.", 
            "39) Implications for practice, including the intended use and/or clinical role.", 
            "40a) Registration number and name of registry for study that generated raw data.", 
            "40b) Registration number and name of registry for reported Machine Learning study.", 
            "41) Where the full study protocol can be accessed.", 
            "42) Sources of funding and other support; role of funders."
)
placeholders <- list("1) Indicate section where this information is provided in the manuscript. ",
                     "2) Indicate section where this information is provided in the manuscript.  ",
                     "3) Indicate section where this information is provided in the manuscript. ",
                     "4) Indicate section where this information is provided in the manuscript. ",
                     "5) Indicate section where this information is provided in the manuscript. ",
                     "6) Indicate section where this information is provided in the manuscript. ",
                     "7a) Copy here the text from your manuscript that states the source of data and indicate how well the data match the intended use of the model and that describes the targeted application of the predictive model to allow readers to interpret the implications of reported accuracy estimates.",
                     "7b) Copy here the text from your manuscript that provides links to data repository, if available.",
                     "7c) Copy here the text from your manuscript that provides links to software/code repository, if available.",
                     "8) Indicate section where this information is provided in the manuscript. ",
                     "9) Indicate section where this information is provided in the manuscript. ",
                     "10)  In  some  studies,  investigators  select  subsets  of  the  raw extracted data as a preprocessing step, for instance, selecting a subset of the images, cropping down to a portion of an image, or extracting a portion of a report. If this process is automated, describe the tools and parameters used; if done manually, specify the training of the personnel and the criteria they used. Justify how this manual step would be accommodated in the context of the clinical or scientific problem to be solved. Indicate section where this information is provided in the manuscript. ",
                     "11)  Define  the  predictor  and  outcome  variables.  Map  them  to  common  data  elements,  if  applicable,  such  as  those  maintained  by  the  radiology  community  (22-24)  or  the  U.S.  National Institutes of Health (25,26). Indicate section where this information is provided in the manuscript. ",
                     "12) Indicate section where this information is provided in the manuscript. ",
                     "13) Indicate section where this information is provided in the manuscript. ",
                     "14) Indicate section where this information is provided in the manuscript. ",
                     "15) Indicate section where this information is provided in the manuscript. ",
                     "16) Indicate section where this information is provided in the manuscript. ",
                     "17) Indicate section where this information is provided in the manuscript. ",
                     "18) Indicate section where this information is provided in the manuscript. ",
                     "19) Indicate section where this information is provided in the manuscript. ",
                     "20) Indicate section where this information is provided in the manuscript. ",
                     "21) Indicate section where this information is provided in the manuscript. ",
                     "22) Indicate section where this information is provided in the manuscript. ", 
                     "23) Indicate section where this information is provided in the manuscript. ", 
                     "24) Indicate section where this information is provided in the manuscript. ", 
                     "25) Indicate section where this information is provided in the manuscript. ", 
                     "26) Indicate section where this information is provided in the manuscript. ", 
                     "27) Indicate section where this information is provided in the manuscript. ", 
                     "28) Indicate section where this information is provided in the manuscript. ", 
                     "29) Indicate section where this information is provided in the manuscript. ", 
                     "30) Indicate section where this information is provided in the manuscript. ",
                     "31) Indicate section where this information is provided in the manuscript. ", 
                     "32) Indicate section where this information is provided in the manuscript. ", 
                     "33) Indicate section where this information is provided in the manuscript. ", 
                     "34) Indicate section where this information is provided in the manuscript. ", 
                     "35a) Indicate section where this information is provided in the manuscript. ", 
                     "35b) Indicate section where this information is provided in the manuscript. ", 
                     "36) Indicate section where this information is provided in the manuscript. ", 
                     "37) Indicate section where this information is provided in the manuscript. ", 
                     "38a) Indicate section where this information is provided in the manuscript. ", 
                     "38b) Indicate section where this information is provided in the manuscript. ", 
                     "39) Indicate section where this information is provided in the manuscript. ", 
                     "40a) Copy here the registration number and URL where the registration can be accessed.", 
                     "40b) Copy here the registration number and URL where the registration can be accessed.", 
                     "41) Indicate section where this information is provided in the manuscript. ", 
                     "42) Indicate section where this information is provided in the manuscript. "
)
noboilers <- c("AI methodology NOT identifiable.",
               "Structured summaries NOT provided.",
               "Scientific and clinical background NOT provided.",
               "Study objectives and hypotheses not described.",
               "Study type not rated or not clear from manuscript.",
               "Study goal NOT clear.",
               "a. Data sources NOT clear.",
               "7b. Data deposited NOT clear." , 
               "7c. Software/code NOT deposited.",
               "Eligibility criteria NOT provided.",
               "Data preprocessing steps NOT described.",
               "Selection of data subsets NOT described.",
               "Definitions of data elements NOT provided.",
               "De-identification methods NOT described.",
               "Handling of missing data NOT described.",
               "Definition of ground truth reference standard NOT provided.",
               "Rationale for choosing the reference standard NOT provided.",
               "Source of ground truth annotations NOT provided.", 
               "Annotation tools NOT documented.",
               "Measurement of inter- and intrarater variability NOT provided.",
               "NO or insufficient description how intended sample size was determined.",
               "NO or insufficient description how data were assigned to partitions.",
               "NO or insufficient description of level at which partitions are disjoint.",
               "NO or insufficient description detailed description of model.", 
               "NO or insufficient description documentetion of software libraries, frameworks, and packages.", 
               "NO or insufficientdescription how model parameters were initialization of model parameters.", 
               "NO or insufficient Details of training approach provided.", 
               "NO or insufficient description of Method to select the final model.", 
               "NO or insufficient description of ensembling techniques.", 
               "NO or insufficient metrics of model performance provided.", 
               "NO statistical measures of significance provided.", 
               "Robustness or sensitivity analysis not provided.", 
               "Methods for explainability or interpretability NOT reported.", 
               "Validation or testing on external data NOT reported.", 
               "Flow of participants or cases NOT repoted.", 
               "Demographic and clinical characteristics for each partition NOT reported.", 
               "a) Performance metrics for optimal model(s) on all data partitions NOT reported.", 
               "35b) Benchmark performance against current standards NOT reported.", 
               " Estimates of diagnostic accuracy and their precision NOT reported.", 
               " Failure analysis of incorrectly classified cases NOT reported.", 
               "a) Summary of results NOT reported.",  
               "38b) Study limitations NOT described.", 
               "Implications for (clinical) practice NOT described.", 
               "a) Registration number and name of registry for study that generated raw data NOT reported.", 
               "40b) Registration number and name of registry for reviewed Machine Learning study NOT reported.", 
               "Access to full study protocol NOT provided.", 
               "Sources of funding and other support and the role of funders NOT disclosed."
)
naboilers <- c(NA, NA, NA, NA,
               NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "NA: no data subsets were used.", # including item 14, point 16
               "NA: No prediction model was used.", "NA: Deitenfication of data (e.g. simulated) not applicable.",
               "NA: No missing data reported.", "NA: No ground truth defined for given problem (e.g. purely exploratory research).", "NA: No reference standard exists.",
               "NA: No ground truth exists.", "NA: No annotation tools were used/needed for given problem.", "NA for given problem.", NA, "NA: No data parititions used.", 
               "NA: No data parititions used.", NA, NA, NA, "NA: No training was applied.", "NA: No model selection was performed.", "NA: No ensemble techniques were used.", NA, NA, NA, 
               "NA: Not defined for used techniques.", NA, 
               NA, NA, NA, NA, "NA: Diagnostic accuracy not applicable.", NA, 
               NA, "NA: no study protocol", NA 
)
strblank <- "This field has been left blank"


# Run checks on vector lengths
if (length(checkIDs)!=ncheck) {
    stop("checkIDs not equal to length of ncheck")
}
if (length(labels)!=ncheck) {
    stop("labels not equal to length of ncheck")
}
if (length(choiceindex)!=ncheck) {
    stop("choiceindex not equal to length of ncheck")
}
if (length(placeholders)!=ncheck) {
    stop("placeholders not equal to length of ncheck")
}
if (length(responseIDs)!=ncheck) {
    stop("responseIDs not equal to length of ncheck")
}
if (length(noboilers)!=ncheck) {
    stop("noboilers not equal to length of ncheck")
}
if (length(naboilers)!=ncheck) {
    stop("naboilers not equal to length of ncheck")
}
if (length(summaryIDs)!=ncheck) {
    stop("summaryIDs not equal to length of ncheck")
}
if (length(sumIDs)!=ncheck) {
    stop("sumIDs not equal to length of ncheck")
}



########################## START UI #############################

ui <- fluidPage(
    titlePanel(h2("Checklist for Artifical Intelligence in Medical Imaging (CLAIM)")),

    navlistPanel(
        "Domains",
        tabPanel("About",
                 tags$div(HTML("<h1><u>C</u>heck<u>l</u>ist for <u>A</u>rtificial <u>I</u>ntelligence in <u>M</u>edical Imaging (CLAIM)</h1>")),
                 tags$div(p("This webpage serves as an online tool to standardize planning and reporting of Machine Learning studies in Medical Imaging. It is based on the", 
                            a(href="https://pubs.rsna.org/doi/10.1148/ryai.2020200029", "Checklist for Artificial Intelligence in Medical Imaging (CLAIM)"), "published as a an editorial in 'Radiology: Artificial Intelligence' by", 
                            a(href="https://profiles.ucsf.edu/john.mongan", "Dr. John Mongan"), "(UCSF)", a(href="https://nyulangone.org/doctors/1922064559/linda-moy", "Dr. Linda Moy"), "(NYU) and", a(href="https://ldi.upenn.edu/expert/charles-e-kahn-jr-md-ms", "Dr. Charles Kahn"), "(UPenn).",
                            "This online tool was inspired by the", a(href="https://crednf.shinyapps.io/CREDnf/", "CRED-nf checklist."),
                            tags$div(p("BEFORE USING, PLEASE NOTE: This is currently a Beta version. If you encounter any bugs when using it or have any feedback, please email mehlerdma@gmail.com with the subject `CLAIM Shiny App` or raise an issue on", 
                                       a(href="https://github.com/neuroccino/CLAIM", "GitHub"), ".",
                            
                                       "This digital version of the CLAIM checklist has been created by", a(href="https://twitter.com/neuroccino", "Dr. David Mehler"), "(University of Muenster). 
                                       The content is taken from the published version of the orinigal manuscript by Mongan et al., 2020 (linked above). The original items 7, 35, 38 and 40 are broken down to more detailed subitems (alphabetically labelled).")) , 
                            
                            "INSTRUCTIONS:", 
                                       
                            "Please select the tabs on the left and answer the questions provided. When you respond 'Yes' to an item, you will be prompted to copy-paste the text from your manuscript that identifies the section that addresses the item. We recommend you also save this copy-pasted text in a text document in case this webpage has a timeout issue.", style = "font-size:15px")),
                 br(),
                 p("When completed, click the 'Download summary' button from the 'Checklist summary' tab. This will produce a table which you can include in your manuscript submission as supplementary material.", style = "font-size:15px"),
                 br(),

        ),
        tabPanel("Manuscript information",
                 textInput("title", label="Manuscript title", width="80%"),
                 textInput("author", label="Corresponding author name", width="80%"),
                 textInput("email", label="Corresponding author email", width="80%")), #textInput("rater", label="Checklist rater name or ID (optional)", width="80%")
        tabPanel("TITLE, ABSTRACT, INTRODUCTION (items 1-4)",
                 h2("Title or Abstract"),
                 lapply(1, function(i) {
                     wellPanel(
                         selectInput(inputIDs[i], h4(),
                                     choices = as.list(choicelist[[choiceindex[i]]]), selected = NULL),
                         uiOutput(newIDs[i]),
                         textOutput(textIDs[i])
                     )
                 }),
                 h2("Abstract"),
                 lapply(2, function(i) {
                   wellPanel(
                     selectInput(inputIDs[i], h4(),
                                 choices = as.list(choicelist[[choiceindex[i]]]), selected = NULL),
                     uiOutput(newIDs[i]),
                     textOutput(textIDs[i])
                   )
                 }), 
                 h2("Introduction"),
                 lapply(3:4, function(i) {
                   wellPanel(
                     selectInput(inputIDs[i], h4(),
                                 choices = as.list(choicelist[[choiceindex[i]]]), selected = NULL),
                     uiOutput(newIDs[i]),
                     textOutput(textIDs[i])
                   )
                 }),
        ),
        
        tabPanel("METHODS (items 5-32)",
                 h2("Study Design"),
                 lapply(5:6, function(i) {
                     wellPanel(
                         selectInput(inputIDs[i], h4(),
                                     choices = as.list(choicelist[[choiceindex[i]]]), selected = NULL),
                         uiOutput(newIDs[i]),
                         textOutput(textIDs[i])
                     )
                 }), 
                 h2("Data"),
                 lapply(7:15, function(i) {
                   wellPanel(
                     selectInput(inputIDs[i], h4(),
                                 choices = as.list(choicelist[[choiceindex[i]]]), selected = NULL),
                     uiOutput(newIDs[i]),
                     textOutput(textIDs[i])
                   )
                 }),
                 h2("Ground truth"),
                 lapply(16:20, function(i) {
                   wellPanel(
                     selectInput(inputIDs[i], h4(),
                                 choices = as.list(choicelist[[choiceindex[i]]]), selected = NULL),
                     uiOutput(newIDs[i]),
                     textOutput(textIDs[i])
                   )
                 }), 
                 h2("Data partitions"),
                 lapply(21:23, function(i) {
                   wellPanel(
                     selectInput(inputIDs[i], h4(),
                                 choices = as.list(choicelist[[choiceindex[i]]]), selected = NULL),
                     uiOutput(newIDs[i]),
                     textOutput(textIDs[i])
                   )
                 }), 
                 h2("Model"),
                 lapply(24:26, function(i) {
                   wellPanel(
                     selectInput(inputIDs[i], h4(),
                                 choices = as.list(choicelist[[choiceindex[i]]]), selected = NULL),
                     uiOutput(newIDs[i]),
                     textOutput(textIDs[i])
                   )
                 }), 
                 h2("Training"),
                 lapply(27:29, function(i) {
                   wellPanel(
                     selectInput(inputIDs[i], h4(),
                                 choices = as.list(choicelist[[choiceindex[i]]]), selected = NULL),
                     uiOutput(newIDs[i]),
                     textOutput(textIDs[i])
                   )
                 }), 
                 h2("Evaluation"),
                 lapply(30:34, function(i) {
                   wellPanel(
                     selectInput(inputIDs[i], h4(),
                                 choices = as.list(choicelist[[choiceindex[i]]]), selected = NULL),
                     uiOutput(newIDs[i]),
                     textOutput(textIDs[i])
                   )
                 })
        ), 
        
        tabPanel("RESULTS (items 33-37)",
                 h2("Data"),
                 lapply(35:40, function(i) {
                   wellPanel(
                     selectInput(inputIDs[i], h4(),
                                 choices = as.list(choicelist[[choiceindex[i]]]), selected = NULL),
                     uiOutput(newIDs[i]),
                     textOutput(textIDs[i])
                   )
                 })
        ),
        
        tabPanel("DISCUSSION (items 38 and 39)",
                 h2("Discussion"),
                 lapply(41:43, function(i) {
                     wellPanel(
                         selectInput(inputIDs[i], h4(),
                                     choices = as.list(choicelist[[choiceindex[i]]]), selected = NULL),
                         uiOutput(newIDs[i]),
                         textOutput(textIDs[i])
                     )
                 })
        ),
        
        tabPanel("OTHER INFORMATION (items 40-42)",
                 h2("Other Informtion"),
                 lapply(44:47, function(i) {
                     wellPanel(
                         selectInput(inputIDs[i], h4(),
                                     choices = as.list(choicelist[[choiceindex[i]]]), selected = NULL),
                         uiOutput(newIDs[i]),
                         textOutput(textIDs[i])
                     )
                 })
        ), 
        
        tabPanel("Checklist summary",
                 tags$span(style="color:red", 
                           strong(em(textOutput("warningtext")))
                 ),
                 
                 h2("CLAIM checklist summary output"),
                 tags$div(
                         tags$ol(
                             h4("Title or Abstract"),
                             lapply(1, function(i) {
                                 tags$li(textOutput(summaryIDs[i]))
                             }),
                             h4("Abstract"),
                             lapply(2, function(i) {
                                 tags$li(textOutput(summaryIDs[i]))
                             }),
                             h4("Introduction"),
                             lapply(3:4, function(i) {
                                 tags$li(textOutput(summaryIDs[i]))
                             }),
                             h4("METHODS (items 5-32)"),
                             h4("Study Design"),
                             lapply(5:6, function(i) {
                                 tags$li(textOutput(summaryIDs[i]))
                             }),
                             h4("Data"),
                             lapply(7, function(i) {
                                 tags$li(textOutput(summaryIDs[i]))
                             }),
                             tags$ul(
                                 tags$li(textOutput(summaryIDs[8])), # new subitems
                                 tags$li(textOutput(summaryIDs[9]))
                             ),
                         ), 
                         tags$ol(start=8, 
                             lapply(10:15, function(i) {
                                 tags$li(textOutput(summaryIDs[i]))
                             }),
                             h4("Ground truth"),
                             lapply(16:20, function(i) {
                                 tags$li(textOutput(summaryIDs[i]))
                             }),
                             h4("Data partitions"),
                             lapply(21:23, function(i) {
                                 tags$li(textOutput(summaryIDs[i]))
                             }),
                             h4("Model"),
                             lapply(24:26, function(i) {
                                 tags$li(textOutput(summaryIDs[i]))
                             }),
                             h4("Trainig"),
                             lapply(27:29, function(i) {
                                 tags$li(textOutput(summaryIDs[i]))
                             }),
                             h4("Evaluation"),
                             lapply(30:34, function(i) {
                                 tags$li(textOutput(summaryIDs[i]))
                             }),
                             h4("RESULTS (items 33-37)"),
                             h4("Data"),
                             lapply(35:37, function(i) {
                                 tags$li(textOutput(summaryIDs[i]))
                             }),
                             tags$ul(
                                 tags$li(textOutput(summaryIDs[38])) # new subitem
                             ),
                         ), 
                         tags$ol(start=36,  
                             h4("Performance"),
                             lapply(39:40, function(i) {
                                 tags$li(textOutput(summaryIDs[i]))
                             }),
                             h4("DISCUSSION (items 38 and 39)"), 
                             
                           lapply(41, function(i) {
                             tags$li(textOutput(summaryIDs[i]))
                           }),
                           tags$ul(
                             tags$li(textOutput(summaryIDs[42])) # new subitem
                           ),
                         ),
                         tags$ol(start=39, 
                           lapply(43, function(i) {
                                tags$li(textOutput(summaryIDs[i]))
                           }), 
                           h4("OTHER (items 40-42)"), 
                           lapply(44, function(i) {
                             tags$li(textOutput(summaryIDs[i]))
                           }), 
                           tags$ul(
                             tags$li(textOutput(summaryIDs[45])) # new subitem
                           ),
                         ),
                         tags$ol(start=41, 
                           lapply(46:47, function(i) {
                               tags$li(textOutput(summaryIDs[i]))
                           }),
                         )
                 ),
                 
                 br(), br(),
                 downloadButton("reportpdf", "Download summary")
        ),
        widths=c(3,9)
    )
    
)



########################## START SERVER #############################

server <- function(input, output, session) {
    
    ############ Observe inputs to react to selections made by user ############
    
    observe({
        for (i in 1:ncheck) {
            updateSelectInput(session, inputId = inputIDs[i], label = labels[i],
                              choices = choicelist[[choiceindex[i]]])
        }
    })
    
    ############ Add text boxes for manuscript info, etc #########
    assign("title", renderText({input$title}))
    assign("author", renderText({input$author}))
    assign("email", renderText({input$email}))
    #assign("rater", renderText({input$rater}))
    

  
    ############ Add open end box to enter text if they user has selected "yes" ############
    
    lapply(1:ncheck, function(i) {
        output[[newIDs[i]]] <- renderUI({
            if (!input[[inputIDs[i]]] %in% c("Yes", 
                                             "Objectives: No; Hypotheses: Yes", 
                                             "Objectives: Yes; Hypotheses: No", 
                                             "Objectives: Yes; Hypotheses: Yes",
                                             "Retrospective", 
                                             "Prospective",
                                             "Partially")) {
                return(NULL)
            } else {
                textAreaInput(responseIDs[i], label=NULL, placeholder=placeholders[[i]])
            }
        })
    })
    
    
    
    ########### Return text ############
    
    lapply(1:ncheck, function(i) {
        output[[paste0("text", checkIDs[i])]] <- renderText({
            if (input[[inputIDs[i]]] %in% c("Yes", "Yes, and the measure was defined a priori", "Yes, and the measure was not defined a priori")) {
                return(input[[responseIDs[i]]])
            }
        })
    })
    
    
    ############# Generate report summary #############
    
    params <- list()
    lapply(1:ncheck, function(i) {
        assign(sumIDs[i],
               reactive({
                   
                   if (input[[inputIDs[i]]] %in% c("Yes",
                                                   "Objectives: No; Hypotheses: Yes", 
                                                   "Objectives: Yes; Hypotheses: No", 
                                                   "Objectives: Yes; Hypotheses: Yes", 
                                                   "Retrospective", 
                                                   "Prospective", 
                                                   "Partially")) {
                       if (input[[responseIDs[i]]]=="") {
                           return(strblank)
                       } else {
                           return(input[[responseIDs[i]]])
                       } 
                   } else if (input[[inputIDs[i]]] %in% c("No",
                                                          "yes", 
                                                          "no", 
                                                          "Objectives: No; Hypotheses: No", 
                                                          "Please Select")) {
                       return(noboilers[i])
                   } 
               }),
               envir=globalenv()
        )
        
        output[[summaryIDs[i]]] <- renderText({eval(parse(text=paste0(sumIDs[i], "()")))})
        
    })
    
    
    ########## Add warning text for items left blank ##########
    
    warningtext <- reactive({
        blankindex <- vector()
        
        for (i in 1:ncheck) {
            if (input[[inputIDs[i]]] %in% c("Yes", "Yes, and the measure was defined a priori", "Yes, and the measure was not defined a priori")) {
                if (input[[responseIDs[i]]]=="") {
                    blankindex <- append(blankindex, i)
                }
            }
        }
        
        if (length(blankindex)>0) {
            return(paste0("Warning: Checklist item(s) ", paste(checkIDs[blankindex], collapse=", "), 
                          " have been left blank."))
        } else {return(NULL)}
    })
    output$warningtext <- renderText(warningtext())
    
    
    ########## Add option to export to PDF and/or Docx ##########
    
    output$reportpdf <- downloadHandler(
         filename = "checklist.pdf",
         content = function(file) {
             # Copy report file to temp directory before processing it to avoid permission issues
             tempReport <- file.path(tempdir(), "report.Rmd")
             file.copy("report.Rmd", tempReport, overwrite = TRUE)
    
             # Set up parameters to pass to Rmd document
             params <- list("title"=title(), "author"=author(), "email"=email(), #, "rater"=rater()
                            "domain1"=c(sum1(), sum2(), sum3(), sum4()),
                            "domain2"=c(sum5(), sum6(), sum7a.Data_Sources(), sum7b.Data_Available(), sum7c.Code_Available(), sum8(), sum9(), sum10(), sum11(), sum12(), sum13(), sum14(),
                                        sum15(), sum16(), sum17(), sum18(), sum19(), sum20(), sum21(),sum22(), sum23(), sum24(), sum25(), sum26(), sum27(), sum28(), sum29(), sum30(), sum31(),sum32()), # METHODS
                            "domain3"=c(sum33(), sum34(), sum35a.Performance(), sum35b.Benchmark(), sum36(), sum37()), # RESULTS
                            "domain4"=c(sum38a.Summary(), sum38b.Limitations(), sum39()), #DISCUSSION
                            "domain5"=c(sum40a.Datacollection_Registered(), sum40b.Analysis_Registered(), sum41(), sum42()),
                            "boilers"=c(noboilers, naboilers, strblank)
             )
    
             # Knit the document using params
             rmarkdown::render(tempReport, output_file = file,
                               params=params,
                               envir=new.env(parent = globalenv()) # Eval in child of global env to isolate Rmd code from app code
             )
         }
     )

}

shinyApp(ui, server)