# Makefile
# Author: Igor Ruiz-Agundez
# Affiliation: DeustoTech, Deusto Institute of Technology, University of Deusto
# Version: v.1.0


###
# TEX configuration
###

# Name of the TEX file to work with
FILE_TEX=SEC_main

###
# Backup configuration
###

# Date stamp style
DATESTAMP=`date +'%Y-%m-%d'`

# Email
# EMAIL=your-email-with-google-account
EMAIL=santiag77e@gmail.com


###
# make execution options
###

all: pdflatex

latex: clean
	latex ${FILE_TEX}.tex
	# Uncomment makeindex if the document contains an index
	makeindex ${FILE_TEX}.nlo -s nomencl.ist -o ${FILE_TEX}.nls
	# bibtex ${FILE_TEX}
	bibtex Int
	latex ${FILE_TEX}.tex
	latex ${FILE_TEX}.tex
	dvipdfm ${FILE_TEX}.dvi
	# Backup tex, bib and generated pdf files
	# There is one backup per day
	mkdir -p time-machine/${DATESTAMP}
	cp ${FILE_TEX}.pdf time-machine/${DATESTAMP}/${FILE_TEX}.pdf

pdflatex: clean	
	pdflatex ${FILE_TEX}.tex
	# Uncomment makeindex if the document contains an index
	makeindex ${FILE_TEX}.nlo -s nomencl.ist -o ${FILE_TEX}.nls
	bibtex Int
	pdflatex ${FILE_TEX}.tex
	pdflatex ${FILE_TEX}.tex
	pdflatex ${FILE_TEX}.tex
	# Backup tex, bib and generated pdf files
	# There is one backup per day
	#mkdir -p time-machine/${DATESTAMP}
	#cp ${FILE_TEX}.pdf time-machine/${DATESTAMP}/${FILE_TEX}.pdf

rtf: clean	
	latex ${FILE_TEX}.tex
	# Uncomment makeindex if the document contains an index
	makeindex ${FILE_TEX}.nlo -s nomencl.ist -o ${FILE_TEX}.nls
	bibtex ${FILE_TEX}
	latex ${FILE_TEX}.tex
	latex ${FILE_TEX}.tex
	latex2rtf ${FILE_TEX}.tex
	# Backup tex, bib and generated rtf files
	# There is one backup per day
	mkdir -p time-machine/${DATESTAMP}
	cp ${FILE_TEX}.pdf time-machine/${DATESTAMP}/${FILE_TEX}.rtf

git-commit: clean
# Commit to previously configured git repository.
# To set up a local repository do:
#	git init
#To add the local repository to a external repo do:
#	git remote add origin remote-repository-URL
# Sets the new remote
#	git remote -v
# Verifies the new remote URL
	git pull
	git add -A
	git commit
	git push origin master

view:
	# Open the pdf document with skim in mac
	open -a skim ${FILE_TEX}.pdf &

clean:
	# Cleaning ${FILE_TEX} related files...
	ls ${FILE_TEX}.* | grep -v \.tex$ | grep -v \.bib$ | xargs rm -fv
	# Cleaning other tex related files if applicable...
	rm -fv *log *aux *dvi *lof *lot *bit *idx *glo *bbl *ilg *toc *ind *blg *out *nlo *brf *nls *pdf 
	# Cleaning in subdirectories *.aux files...
	find . -regex '.*.aux' -print0 | xargs -0 rm -rfv
	# Cleaning in subdirectories *.log files...
	find . -regex '.*.log' -print0 | xargs -0 rm -rfv
	# Cleaning in subdirectories *.bbl files...
	find . -regex '.*.bbl' -print0 | xargs -0 rm -rfv
	# Cleaning in subdirectories *.blg files...
	find . -regex '.*.blg' -print0 | xargs -0 rm -rfv
	# If there are other generated files, add the previous command again with the proper extension


