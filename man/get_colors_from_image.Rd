% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_colors_from_image.R
\name{get_colors_from_image}
\alias{get_colors_from_image}
\title{The get_colors_from_image function}
\usage{
get_colors_from_image(image, n = 5)
}
\arguments{
\item{image}{The path to the .jpg image.}

\item{n}{The number of colors in the palette. Defaults to 5.}
}
\value{
The hex codes of the n colors in the palette
}
\description{
This function allows you to identify the dominant colors in a jpg image.
}
\examples{
get_colors_from_image("https://upload.wikimedia.org/wikipedia/commons/e/e3/Red-eyed_Tree_Frog_\%28Agalychnis_callidryas\%29_1.png")
}