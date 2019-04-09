web: index.html research.html teaching.html programs.html links.html 102.html 310.html

index.html: index.mro.html
	cat index.mro.html | mro > index.html

research.html: research.mro.html
	cat research.mro.html | mro > research.html

teaching.html: teaching.mro.html
	cat teaching.mro.html | mro > teaching.html

programs.html: programs.mro.html
	cat programs.mro.html | mro > programs.html

links.html: links.mro.html
	cat links.mro.html | mro > links.html

102.html: 102.mro.html
	cat 102.mro.html | mro > 102.html

310.html: 310.mro.html
	cat 310.mro.html | mro > 310.html



