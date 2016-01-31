# Standard disclaimer applies:
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# This software was produced using the facilities of Universiti Putra Malaysia,
# Malaysia.

library(psych)
dataset <- sat.act

shinyUI(pageWithSidebar(
    headerPanel("sat.act SLR Explorer"),
    sidebarPanel(
        selectInput("y", "Y", names(dataset), "ACT"),
        selectInput("x", "X", names(dataset), "education"),
        checkboxInput('jitter', 'Jitter', TRUE),
        checkboxInput('regLine', 'Regression line', TRUE),
        p("P-value codes (less than or equal):", br(),
          "'***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1"),
        hr(),
        h4("Documentation"),
        p("The Y and X input boxes change what is shown on the Y-axis and ",
          "X-axis respectively. The Jitter checkbox adds some random noise ",
          "so that overlapping points are made obvious, while the Regression ",
          "line checkbox adds a regression line with slope and p-value given ",
          "in the title. Try them and see!"),
        p("To get the code (", code("ui.R"), "and", code("server.R"), "), use",
          a("this link to GitHub.",
            href = "https://github.com/kazarmy/DevDataProdProject")),
        h4("Disclaimer"),
        p("IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS OF THIS ",
          "SOFTWARE BE LIABLE FOR ANY DAMAGES ARISING IN ANY WAY OUT OF THE ",
          "USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH ",
          "DAMAGE. Yes I know factor variables are treated improperly, but ",
          "this application is for exploration, not for drawing conclusions.")
    ),
    mainPanel(
        plotOutput("lmPlot"),
        htmlOutput("eduHelp")
    )
))