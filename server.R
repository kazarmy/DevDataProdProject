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

shinyServer(
    function(input, output) {

        # Reactive output: plot.
        output$lmPlot <- renderPlot({
            set.seed(32323)
            x <- dataset[,input$x]
            y <- dataset[,input$y]

            # Add jitter if required.
            if (input$jitter) {
                plotted.x <- jitter(x)
                plotted.y <- jitter(y)
            } else {
                plotted.x <- x
                plotted.y <- y
            }

            # Suppress the normal axis if gender is plotted.
            if (input$x == "gender") {
                par(xaxt = "n")
            }
            if (input$y == "gender") {
                par(yaxt = "n")
            }

            # Change title if regression line is plotted.
            if (input$regLine) {
                fit <- lm(y ~ x)
                coefs <- summary(fit)$coefficients
                slope <- coefs[2, 1]
                slope.pval <- coefs[2, 4]
                slope.pval.sym <- symnum(
                    slope.pval, corr = FALSE,
                    cutpoints = c(0, 0.001, 0.01, 0.05, 0.1, 1),
                    symbols = c("***", "**", "*", ".", " "))
                title <- paste("Slope = ", round(slope, 6), ", p-value = ",
                               format.pval(slope.pval), " ", slope.pval.sym,
                               sep = "")
            } else {
                title <- paste("Plot of", input$y, "vs.", input$x)
            }

            # Do the plot.
            plot(x = plotted.x, y = plotted.y, xlab = input$x, ylab = input$y,
                 type = "p", main = title)

            # Plot the regression line if required.
            if (input$regLine) {
                abline(fit, col = "blue")
            }

            # Add customized axis for gender if it is plotted.
            if (input$x == "gender") {
                par(xaxt = "s")
                axis(side = 1, at = c(1, 2), labels = c("male", "female"))
            }
            if (input$y == "gender") {
                par(yaxt = "s")
                axis(side = 2, at = c(1, 2), labels = c("male", "female"))
            }
        })

        # Reactive output: education help.
        output$eduHelp <- renderUI({
            if ("education" %in% c(input$x, input$y)) {
                eduHelpText <- c(
                    "----",
                    paste0("For education, the numbers apparently have the ",
                           "following meaning:"),
                    "0: Less than 12 years",
                    "1: High school graduate",
                    "2: Some college, did not graduate",
                    "3: Currently attending college",
                    "4: College graduate",
                    "5: Graduate or professional degree",
                    "",
                    paste0("(From Table 2.3 in Revelle, William, Wilt, ",
                           "Joshua, and Rosenthal, Allen (2010). Individual ",
                           "Differences in Cognition: New Methods for ",
                           "Examining the Personality-Cognition Link. In ",
                           "Gruszka, Aleksandra, Matthews, Gerald and ",
                           "Szymura, Blazej (Eds.) Handbook of Individual ",
                           "Differences in Cognition: Attention, Memory and ",
                           "Executive Control, Springer.)"))
                HTML(paste0(eduHelpText, collapse = "<br/>"))
            } else {
                HTML("")
            }
        })
    }
)