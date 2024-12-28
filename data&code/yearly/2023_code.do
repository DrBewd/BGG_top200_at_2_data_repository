*************
*BGG top 200*
*************


cd "/Users/-/Desktop/BGG/Top200"


*Import data
clear
import excel bgg_top_200_2023, firstrow sheet(Template) case(lower)
keep uid id rank game

*********************
*Clean textual input*
*********************

gen game_lower=lower(game)

*Check all unique entries
fre game_lower, all

*Correct typos
replace game_lower="advanced squad leader: starter kit 1 " if game_lower=="advanced squad leader starter kit 1 "
replace game_lower="air, land, & sea: critters at war" if game_lower=="air,land & sea: critters at war"
replace game_lower="antike duellum" if game_lower=="antike duellem"
replace game_lower="arkham horror (third edition)" if game_lower=="arkham horror 3rd edition"
replace game_lower="artifacts, inc." if game_lower=="artifacts inc."
replace game_lower="bohnanza: the duel " if game_lower=="bohanza: the duel "
replace game_lower="boop" if game_lower=="boop."
replace game_lower="brass: birmingham" if game_lower=="brass"
replace game_lower="brass: birmingham" if game_lower=="brass birmingham"
replace game_lower="brass: birmingham" if game_lower=="brass: birminghmam"
replace game_lower="brass: birmingham" if game_lower=="brass:: birmingham"
replace game_lower="burgle bros." if game_lower=="burgle bros"
replace game_lower="bärenpark" if game_lower=="barenpark"
replace game_lower="caesar!: seize rome in 20 minutes" if game_lower=="caesar!: seize rome"
replace game_lower="caper: europe" if game_lower=="caper europe"
replace game_lower="carcassonne" if game_lower=="carcassone"
replace game_lower="the castles of burgundy" if game_lower=="castles of burgundy"
replace game_lower="catchy!" if game_lower=="catchy"
replace game_lower="caverna: the cave farmers" if game_lower=="caverna"
replace game_lower="century: spice road" if game_lower=="century spice road"
replace game_lower="challengers!" if game_lower=="challengers"
replace game_lower="clank!: catacombs " if game_lower=="clank! catacombs"
replace game_lower="codenames: duet" if game_lower=="codename duet"
replace game_lower="codex: card-time strategy - deluxe set" if game_lower=="codex card time strategy deluxe set"
replace game_lower="combat commander: europe" if game_lower=="combat commander europe"
replace game_lower="cthulhu wars: duel " if game_lower=="cthulhu wars duel "
replace game_lower="décorum" if game_lower=="decorum"
replace game_lower="deep space d-6: armada" if game_lower=="deep space d-6 armada"
replace game_lower="dorfromantik: the board game" if game_lower=="dorfromantik"
replace game_lower="dune: imperium" if game_lower=="dune imperium"
replace game_lower="fantasy realms" if game_lower=="fantasy realm"
replace game_lower="the fox in the forest" if game_lower=="fox in the forest"
replace game_lower="grand austria hotel" if game_lower=="grand austia hotel"
replace game_lower="the guild of merchant explorers" if game_lower=="guild of merchant explorers"
replace game_lower="hnefatafl" if game_lower=="hnafatal"
replace game_lower="it's a wonderful world" if game_lower=="it's wonderful world"
replace game_lower="jekyll vs. hyde" if game_lower=="jekyll vs hyde"
replace game_lower="jekyll vs. hyde" if game_lower=="jekyll vs. hyde (2021)"
replace game_lower="kōhaku" if game_lower=="kohaku"
replace game_lower="the lord of the rings: the card game" if game_lower=="lord of the rings lcg"
replace game_lower="the lord of the rings: the card game" if game_lower=="lord of the rings: the card game"
replace game_lower="lost ruins of arnak" if game_lower=="lost ruina of arnak"
replace game_lower="marvel champions: the card game" if game_lower=="marvel champions"
replace game_lower="my city: roll & build" if game_lower=="my city roll and build"
replace game_lower="next station: london" if game_lower=="next station london"
replace game_lower="next station: tokyo" if game_lower=="next station tokyo"
replace game_lower="nusfjord" if game_lower=="nusjford"
replace game_lower="oathsworn: into the deepwood" if game_lower=="oathsworn"
replace game_lower="obsession" if game_lower=="obsesssion"
replace game_lower="orléans" if game_lower=="orleans"
replace game_lower="pagan: fate of roanoke" if game_lower=="pagan"
replace game_lower="paris: la cité de la lumière" if game_lower=="paris: la cite de la lumiere"
replace game_lower="patchwork" if game_lower=="patchwork folklore: china"
replace game_lower="portals" if game_lower=="portals (2023)"
replace game_lower="the quacks of quedlinburg" if game_lower=="quacks of quedlinburg"
replace game_lower="santorini: new york" if game_lower=="santorini new york"
replace game_lower="schotten totten" if game_lower=="schottentotten"
replace game_lower="sea, salt & paper" if game_lower=="sea salt & paper"
replace game_lower="sea, salt & paper" if game_lower=="sea,salt & paper"
replace game_lower="sekigahara: the unification of japan" if game_lower=="sekigahara"
replace game_lower="set" if game_lower=="set (1988)"
replace game_lower="7 wonders duel" if game_lower=="seven wonders duel"
replace game_lower="stardew valley: the board game" if game_lower=="stardew valley"
replace game_lower="the taverns of tiefenthal" if game_lower=="taverns of tiefenthal"
replace game_lower="terraforming mars: ares expedition" if game_lower=="terraforming mars: ares edition"
replace game_lower="that's pretty clever!" if game_lower=="that's pretty clever"
replace game_lower="the crew: the quest for planet nine" if game_lower=="the crew: quest for planet nine"
replace game_lower="the lord of the rings: the card game" if game_lower=="the lord of the rings the card game"
replace game_lower="the lord of the rings: the card game" if game_lower=="the lord of the rings: card game"
replace game_lower="the lord of the rings: journeys in middle-earth" if game_lower=="the lord of the rings: journeys on middle-earth"
replace game_lower="undaunted: normandy" if game_lower=="undaunted normandy"
replace game_lower="unlock!" if game_lower=="unlock"
replace game_lower="vikings" if game_lower=="vikings (2007)"
replace game_lower="viticulture essential edition" if game_lower=="viticulture:essential edition"
replace game_lower="war of the ring" if game_lower=="war of the rings"
replace game_lower="welcome to..." if game_lower=="welcome to…"

***************
*Data cleaning*
***************

*Convert rank and reverse scale
destring rank, generate(rank_n)
vreverse rank_n, generate(score)

lab def score 1"1", replace
foreach x of numlist 2/20 {
	
lab def score `x'"`x'", add

}

*Convert game
encode game_lower, generate(games)


*Aggregate title (WORK IN PROGRESS)
gen family=games

label copy games families
lab val family families

recode family (4=5)(16=15)(20=19)(103=104)(106 107 109=105)(122=121)(139=640) ///
(148=147)(154=153)(189=188)(258 277=276)(264=263)(284=283)(296=295) ///
(306 307=305)(320=319)(324=323)(330=329)(385=384)(397=673)(400 183=182) ///
(438=439)(476=477)(514=513)(534=533)(549=548)(551=58)(597=595)(608=605) ///
(620=621)(646=645)(649 651=650)(681 683=680)(684=682)(718 720 721=719)(739=740)

/* Changes
-51st state: master set -> 51st state: ultimate edition
-agricola (revised edition) -> agricola
-air, land, & sea: critters at war -> air, land, & sea
-caper -> caper: europe
-carcassonne: hunters and gatherers | carcassonne: over hill and dale | carcassonne: the discovery -> carcassonne
century: spice road -> century: golem edition
-Clever 4Ever -> that's pretty clever!
-concordia venus -> concordia
-creature comforts: kickstarter edition -> creature comforts
-dominion (second edition) -> dominion
-frosthaven | gloomhaven: jaws of the lion -> gloomhaven
-galaxy trucker (2nd edition)  -> galaxy trucker
-great western trail: second edition -> great western trail
harry potter: hogwarts battle – defence against the dark arts -> harry potter: hogwarts battle
-hive carbon | hive pocket -> hive
-imperial settlers: empires of the north -> imperial settlers
-ingenious: travel edition -> ingenious
-istanbul: big box -> istanbul
love letter: adventure time -> love letter
marco polo ii: in the service of the khan -> the voyages of marco polo
-marvel dice throne | dice throne adventures -> dice throne
-next station: london -> next station: tokyo
pax renaissance -> pax renaissance (2nd edition)
-railroad ink challenge -> railroad ink
-rococo: deluxe plus edition -> rococo
-santorini: new york -> santorini
-schotten totten -> battle line
-splendor: marvel -> splendor
star wars: x-wing (second edition) -> star wars: x-wing
-summoner wars -> summoner wars (second edition)
-the castles of burgundy: special edition -> the castles of burgundy
-the crew | the crew: the quest for planet nine -> the crew: mission deep sea
-ticket to ride: europe | ticket to ride: marklin -> Ticket to ride
-ticket to ride: new york -> ticket to ride: london
-undaunted | undaunted: north africa | undaunted: stalingrad -> undaunted: normandy
-war of the ring -> war of the ring: second edition
*/

lab def families 513"railroad ink: deep blue edition", modify


*Rename labels
lab var uid "unique identifier"
lab var id "user identifier"
lab var score "Individual score"
lab var family "Aggregated games"



***********************************
*Prepare data for Network Analysis*
***********************************

*Data matrix
preserve
drop if games==. 
nw_fromlist network, node(family) id(id)
export excel using matrix.xlsx, firstrow(var) replace
restore

*********
*Results*
*********

*Final score
bysort family: egen score_f = total(score)


*Average vote
bysort family: egen avg_vote = mean(rank_n)


*Standard Deviation
bysort family: egen std = sd(rank_n)


*Number of votes
bysort family: egen count_tot = count(rank_n)


*Highest rating
bysort family: egen max_vote = min(rank_n)


*Number of #1 votes
bysort family: egen count1 = total(rank_n==1)


*Rank
duplicates drop family, force
gsort -score_f +avg_vote -count_tot -count1 +max_vote

su family
egen placement = seq(), f(`r(min)') t(`r(max)')

***********************************
*Prepare data for Network Analysis*
***********************************
preserve
keep family score_f
drop if family==.
rename family id
order id, first
export excel using weighted_nodes.xlsx, firstrow(var) replace
restore

*************
*Export data*
*************

gen year = 2023
keep games-year
order year, a(games)
order placement, b(score_f)


