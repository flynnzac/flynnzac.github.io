web: index.html research.html teaching.html programs.html links.html 102.html 310.html

index.html: index.mro.html mysite.mro
	cat index.mro.html | pushmac > index.html

research.html: research.mro.html mysite.mro
	cat research.mro.html | pushmac > research.html

teaching.html: teaching.mro.html mysite.mro
	cat teaching.mro.html | pushmac > teaching.html

programs.html: programs.mro.html mysite.mro
	cat programs.mro.html | pushmac > programs.html

links.html: links.mro.html mysite.mro
	cat links.mro.html | pushmac > links.html

102.html: 102.mro.html mysite.mro
	cat 102.mro.html | pushmac > 102.html

310.html: 310.mro.html mysite.mro
	cat 310.mro.html | pushmac > 310.html



