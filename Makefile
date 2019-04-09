web: index.html research.html teaching.html programs.html links.html 102.html 310.html

index.html: index.mro.html mysite.mro
	cat index.mro.html | mro > index.html

research.html: research.mro.html mysite.mro
	cat research.mro.html | mro > research.html

teaching.html: teaching.mro.html mysite.mro
	cat teaching.mro.html | mro > teaching.html

programs.html: programs.mro.html mysite.mro
	cat programs.mro.html | mro > programs.html

links.html: links.mro.html mysite.mro
	cat links.mro.html | mro > links.html

102.html: 102.mro.html mysite.mro
	cat 102.mro.html | mro > 102.html

310.html: 310.mro.html mysite.mro
	cat 310.mro.html | mro > 310.html



