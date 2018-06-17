
all : geography.xlsx population.xlsx lex.xlsx gdp.xlsx co2_percap.xlsx
	Rscript ingest.R


geography.xlsx :
	wget -O geography.xlsx http://gapm.io/dl_geo

population.xlsx :
	wget -O population.xlsx http://gapm.io/dl_pop

lex.xlsx :
	wget -O lex.xlsx https://github.com/Gapminder-Indicators/lex/raw/master/lex-by-gapminder.xlsx

gdp.xlsx :
	wget -O gdp.xlsx https://github.com/Gapminder-Indicators/gdppc_cppp/raw/master/gdppc_cppp-by-gapminder.xlsx

co2_percap.xlsx :
	wget -O co2_percap.xlsx 'https://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj1gkNuUEXOGag&output=xlsx'