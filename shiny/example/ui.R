library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Illustrating markup"),
  sidebarPanel(
    numericInput('id1', 'Numeric input, labeled id1', 0, min = 0, max = 10, step = 1),
    checkboxGroupInput('id2', 'Checkbox',
                       c('Value 1' = '1',
                         'Value 2' = '2',
                         'Value 3' = '3')),
    dateInput('date', 'Date:'),
    h1('Sidebar panel'),
    h1('H1 text'),
    h2('H2 text'),
    h3('H3 text'),
    h4('H4 text')
  ),
  mainPanel(
    h3('Illustrating outputs'),
    h4('You entered'),
    verbatimTextOutput('oid1'),
    h4('You entered'),
    verbatimTextOutput('oid2'),
    h4('You entered'),
    verbatimTextOutput('odate'),
    code('some code'),
    p('some ordinary text')
  )
))