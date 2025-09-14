web: index.html research.html projects.html toolshed.html cv.html presentations.html consulting.html blogmap.html

index.html: index.pushmac.html website.pushmac
	cat index.pushmac.html | pushmac > index.html

research.html: research.pushmac.html website.pushmac
	cat research.pushmac.html | pushmac > research.html

projects.html: projects.pushmac.html website.pushmac
	cat projects.pushmac.html | pushmac > projects.html

toolshed.html: toolshed.pushmac.html website.pushmac
	cat toolshed.pushmac.html | pushmac > toolshed.html

consulting.html: consulting.pushmac.html website.pushmac
	cat consulting.pushmac.html | pushmac > consulting.html

cv.html: cv.pushmac.html website.pushmac slides/cv.html
	cat cv.pushmac.html | pushmac > cv.html

presentations.html: presentations.pushmac.html website.pushmac
	cat presentations.pushmac.html | pushmac > presentations.html


blogmap.html: blogmap.pushmac.html website.pushmac
	cat blogmap.pushmac.html | pushmac > blogmap.html
