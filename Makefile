web: index.html research.html teaching.html programs.html links.html 102.html 310.html

index.html: index.pshm.html mysite.pshm
	cat index.pshm.html | pushmac > index.html

research.html: research.pshm.html mysite.pshm
	cat research.pshm.html | pushmac > research.html

teaching.html: teaching.pshm.html mysite.pshm
	cat teaching.pshm.html | pushmac > teaching.html

programs.html: programs.pshm.html mysite.pshm
	cat programs.pshm.html | pushmac > programs.html

links.html: links.pshm.html mysite.pshm
	cat links.pshm.html | pushmac > links.html

102.html: 102.pshm.html mysite.pshm
	cat 102.pshm.html | pushmac > 102.html

310.html: 310.pshm.html mysite.pshm
	cat 310.pshm.html | pushmac > 310.html



