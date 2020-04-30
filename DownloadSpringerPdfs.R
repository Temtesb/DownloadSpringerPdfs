pacman::p_load(pacman, readxl, stringr)

mainDir<-choose.dir()
subDir<-"Springer"
dir.create(file.path(mainDir,subDir))

baseUrl<-"https://resource-cms.springernature.com/springer-cms/rest/v1/content/17858272/data/v4"

download.file(url=baseUrl,destfile = "books.xlsx", mode = "wb")
books<-read_xlsx("books.xlsx")

filesToDownload<-books$`DOI URL`

downloadUrlBase<-"https://link.springer.com/content/pdf/10.1007%2F"
fileNames<-file.path(file.path(mainDir, subDir),paste0(books$`Book Title`,".pdf"))

filesToDownload2<-paste0(downloadUrlBase,str_sub(filesToDownload,24,nchar(filesToDownload)),".pdf")

for(i in seq_along(filesToDownload2)){
  download.file(filesToDownload2[i], destfile=fileNames[i], mode="wb")
}


p_unload(all)
