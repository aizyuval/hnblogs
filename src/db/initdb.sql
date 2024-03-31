--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

CREATE DATABASE hnblogsdb;
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: tbllinks; Type: TABLE; Schema: public; Owner: postgres
--

\c hnblogsdb;
CREATE TABLE public.tbllinks (
    title text NOT NULL,
    url text NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.tbllinks OWNER TO postgres;

--
-- Name: tbllinks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbllinks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbllinks_id_seq OWNER TO postgres;

--
-- Name: tbllinks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbllinks_id_seq OWNED BY public.tbllinks.id;


--
-- Name: tbllinks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbllinks ALTER COLUMN id SET DEFAULT nextval('public.tbllinks_id_seq'::regclass);


--
-- Data for Name: tbllinks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbllinks (title, url, id) FROM stdin;
Double Space Court Case	https://azeemba.com/	1
Int->Float->Int: It's a jungle out there	https://blog.bjornroche.com/	2
Prompt Engineering Hacks to Get 10x Better Results	https://unwindai.substack.com/	3
The Browser Company feels gross to me right now	https://birchtree.me/	4
How to use PostgreSQL for (military) geoanalytics tasks	https://klioba.com/	5
Talking About Layoffs (2022)	https://angelariggs.github.io/	6
Why can't we talk about this?	https://karadansky.substack.com/	7
Gardens and Power	https://werd.io/	8
The Psychology of Social Status and Class: My Conversation with Jordan Peterson	https://www.robkhenderson.com/	9
Nitter Is Not Dead	https://gabrielsimmer.com/	10
The De-Google Project	https://www.tbray.org/	11
Paging for Non-Paginated back end	https://medium.com/	12
Bookmarklets for Testing Your Website	https://adactio.com/	13
My Guide to Software Engineering Contracting in UK	https://codedeepdives.com/	14
The Best Essay	https://paulgraham.com/	15
Sorting with CUDA (SIMD) Shuffling	https://winwang.blog/	16
Surveillance Through Push Notifications	https://www.schneier.com/	17
Writing Documentation for Your Team	https://www.shubhro.com/	19
Preparing to Attend KubeCon Europe 2024	https://davidgomes.com/	20
About Link Integrity	https://vhyrro.github.io/	21
Ironies of Automation (1983)	https://www.complexcognition.co.uk/	22
Tips to Help Yourself Stand Out During a Tech Job Search	https://seankilleen.com/	23
Efficient Instance Resolution for Agda	https://amelia.how/	24
Read it never	https://prertik.com/	25
Resolv.conf (Upper Case)	https://jpmens.net/	26
Rebuilding memchess.com from its archive	https://grondilu.github.io/	27
What do Norway and Namibia have in common?	https://ivdl.co.za/	28
Collecting entropy by human input in the browser using JavaScript	https://blog.laughingman.dev/	29
LLM with Ollama and similarity search with Qdrant, vector database	https://vincent.composieux.fr/	30
HN-Index	https://www.alexmolas.com/	31
Banning Open Weight Models Would Be a Disaster	https://rbren.substack.com/	32
Serving Astro with Rust	https://www.yieldcode.blog/	33
Automating Cargo project configuration using cargo-wizard	https://kobzol.github.io/	34
Homebrew All the Python Things	https://blog.davep.org/	35
Using my new Raspberry Pi to run an existing GitHub Action	https://blog.frankel.ch/	36
Why Browsers Get Built	https://infrequently.org/	37
The hottest new programming language is English Or maybe not	https://garymarcus.substack.com/	38
How to Deal with Negative Behavior	https://peterszasz.com/	39
Technical Skills Are Overrated. Focus on Your Attitude	https://www.scarletink.com/	40
Super Specific Feedback: How to give actionable feedback on work output	https://newsletter.weskao.com/	41
Sharing links via RSS, sharing links via APIs	https://coryd.dev/	42
Pro tip: Write your email in a separate text editor then copy it into Gmail	https://1f6042.blogspot.com/	43
Regex character "$" doesn't mean "end-of-string"	https://sethmlarson.dev/	44
SSH-via-Cloudflare-tunnel: Alternative way to expose machines behind NAT	https://taras.glek.net/	45
Biscotti, a new crate for HTTP cookies	https://www.lpalmieri.com/	46
100 (more) things you can do with your personal website	https://jamesg.blog/	47
The Most Important Skill in Startup Engineering Leadership	https://danielmangum.com/	48
The Agony and the Ecstasy of Deep Brain Stimulation Surgery (2021)	https://tmrwedition.com/	49
The most important goal in designing software is understandability	https://ntietz.com/	50
Can AI Solve Science?	https://writings.stephenwolfram.com/	51
Cloning a Laptop over NVMe TCP	https://copyninja.in/	52
Snowflake, the Missing Primer	https://calpaterson.com/	53
Physics vs. Magic	https://xkcd.com/	54
How 3 Books Rewired My Brain	https://abitgamey.substack.com/	55
Iris (Infra-Red, in Situ) Silicon Verification Project Updates	https://www.bunniestudios.com/	56
How "new type" helps avoid production outages	https://blogsystem5.substack.com/	57
Keycloak Identity and Access Management on FreeBSD	https://vermaden.wordpress.com/	58
I switched to Cloudflare Tunnel and ditched Ngrok	https://aien.me/	59
Browsertech NYC Meetup Recap	https://www.petemillspaugh.com/	60
Deterministic Password Managers Revisited	https://samuellucas.com/	61
eBPF Documentary	https://www.brendangregg.com/	62
Why Can't Programmers Agree on Anything?	https://jesseduffield.com/	63
The Only Way to Make Money (2022)	https://taylor.town/	64
Musical Tone and Perceived Dissonance (2011)	https://blog.andymatuschak.org/	65
How the Devteam Conquered the iPhone	https://fabiensanglard.net/	66
Semantics of timezone-aware datetime arithmetic	https://blog.ganssle.io/	67
The Museum of Sonique	https://www.glop.org/	68
Bell Labs: An Institute of Creative Technology (2015)	https://sts10.github.io/	69
Three new on-call providers emerge in a week. What gives?	https://www.bobbytables.io/	70
Daring Fireball on latest in Epic-Apple saga	https://daringfireball.net/	71
Implementing Scoped Defer in C	https://btmc.substack.com/	72
A compact relocation format for ELF	https://maskray.me/	73
Copy/paste plain text should be the default	https://rubenerd.com/	74
Divide and conquer: right concerns to separate	https://www.vorant94.io/	75
Show HN: 1-qubit quantum circuit simulator with interactive bloch sphere	https://dazkins.com/	76
People Problem and Platform Engineering	https://blog.christianposta.com/	77
Numbers every programmer should know	https://samwho.dev/	78
Tether, FTX, and Deltec Bank: Money Time	https://amycastor.com/	79
Notes from a data witch – A foundation in Julia	https://blog.djnavarro.net/	80
Show HN: Make SQLite Queries Against Multiple Endpoints in Deno (Val Town)	https://postpostscript-blog.web.val.run/	110
Disruption Comes to Google	https://dareobasanjo.medium.com/	111
Make Better Documents	https://www.anildash.com/	113
A copy of a copy of a copy: FDA medical device clearances	https://wcedmisten.fyi/	114
Some Shortcomings of CSRankings	https://data-mining.philippe-fournier-viger.com/	115
Psychological Superconductivity	https://taiquinnwhyte.substack.com/	116
2024 Oscar Predictions by 5 LLMs	https://www.adamgrant.info/	118
mRNA vaccines: let's eradicate herpes, cure cancer, and be sick a whole lot less	https://bessstillman.substack.com/	119
Getting Started Programming Spaceships	https://staffordwilliams.com/	120
Tabletop Games Based on Math Problems –| Math ∩ Programming	https://www.jeremykun.com/	121
Your company should be a vehicle for the life you want	https://www.ggnotes.com/	123
Building Phomo, Part 1: The Calendar	https://yungchomsky.substack.com/	124
The Orange Pi Zero 3	https://taoofmac.com/	125
QuePaxa: Escaping the Tyranny of Timeouts in Consensus	https://bford.info/	126
Reverse Engineering Protobuf Definitions from Compiled Binaries	https://arkadiyt.com/	127
HTTP Response Status Codes	https://ronaldsvilcins.com/	128
How Fast the Days Are Getting Longer (2023)	https://joe-antognini.github.io/	129
How modern camera shutters work	https://blog.kasson.com/	130
Web Components in Earnest	https://naildrivin5.com/	131
Contra the ACMG on Polygenic Embryo Screening	https://www.parrhesia.co/	132
Three Components of Social Order	https://arnoldkling.substack.com/	133
100 Years of Rent Control in Sweden	https://www.betonit.ai/	134
Why do people bother with open source?	https://bunkum.us/	135
Phalanx's Twilight, Legion's Triumph, Part IIIb: Pyrrhus	https://acoup.blog/	136
A Relatively Important Question from a Reader	https://profmattstrassler.com/	137
Using LLMs to Generate Fuzzers	https://verse.systems/	138
Real-Time Visual and Machine Learning Systems	https://absorensen.github.io/	139
Age of Invention: The Second Soul, Part I	https://www.ageofinvention.xyz/	140
The Inner Game of Tennis	https://www.thomas-huehn.com/	141
How fast can we process a CSV file	https://datapythonista.me/	142
Digital Audio Mixer Pt.2	https://blog.brixit.nl/	143
LLMs Understand Base64	https://florian.github.io/	144
Show HN: Halve-Z – a retro theme for Zola	https://failsafe.monster/	145
Rebuilding FourSquare for ActivityPub Using OpenStreetMap	https://shkspr.mobi/blog/	112
The Case for College	https://www.zdziarski.com/blog/	122
Single Purpose Robots	https://www.samhillier.co/	146
High Performance iOS Apps	https://jacobbartlett.substack.com/	147
Being a Fast, Cogent Writer Is Useful	https://v5.chriskrycho.com/	148
Reflections on Pox Romana	https://www.markkoyama.com/	149
AGI may never align with human needs – so says science	https://markgreville.ie/	150
American science fiction writers and the Vietnam War (2014)	https://alexcoxfilms.wordpress.com/	151
Could AI Outshine Us in Ethical Decision-Making?	https://www.beyond2060.com/	152
The Not Rocket Science Rule of Software Engineering (2014)	https://graydon2.dreamwidth.org/	153
Solving the Nerd-Sniping Problem: When Electronics Meets Heat Equations	https://praveshkoirala.com/	154
Shutting Down My Startup	https://suraj.sh/	155
Is It Time for You to Set Up Tailscale ACLs?	https://blog.patshead.com/	156
How to Lose Control of Your Shell	https://registerspill.thorstenball.com/	157
HaaA – Humans as an API	https://rushabhnagda11.github.io/	158
Samsung won't sell you a phone if you live in East Fairview, North Dakota	https://hardfault.life/	159
Streaming HTML	https://ar.al/	160
How to Produce Green Hydrogen for $1/kg (2023)	https://caseyhandmer.wordpress.com/	161
The Deposit Myth: How a linguistic glitch confuses the hell out of economists	https://www.asomo.co/	162
The Persistent Role of Retrieval Augmented Generation (RAG) Amidst LLM Advances	https://nitishagar.medium.com/	163
How Are WLAN Infrastructures in Enterprises Secured?	https://tbhaxor.com/	164
The Acme Klein Bottle (From Cliff Stoll and Family)	https://blog.jgc.org/	165
Work Hard and Take Everything Seriously	https://macwright.com/	166
Stylized image binning algorithm, for the web	https://benjdd.com/	167
My 4 Monitor Computer Setup	https://guzey.com/	168
Don't waste time thinking you have time	https://nightoftheknight.com/	169
In defense of swap: common misconceptions (2018)	https://chrisdown.name/	170
The only thing I want AI to help me automate are its own users	https://ivanca.tumblr.com/	171
Why I Blog	https://muratbuffalo.blogspot.com/	172
How to migrate data off PlanetScale in 5 minutes	https://blog.vikrantbhat.com/	173
Apple curl security incident 12604	https://daniel.haxx.se/	174
Remote Work Patterns	https://chi.pl/	175
Car Electronics in a Portable Box	https://blog.quarkslab.com/	176
5,800 pounds of batteries tossed off the ISS in 2021 will fall to Earth today	https://www.leonarddavid.com/	177
NSA, NIST, and post-quantum cryptography	https://blog.cr.yp.to/	178
Breaking Murmur: Hash-Flooding DoS Reloaded (2012)	https://emboss.github.io/	179
Using simpler tools to force simplicity	https://para.bearblog.dev/	180
Restrictions	https://47nil.com/	181
Reflections on a Startup Misstep: A Decade of Perspective	https://vertis.io/	182
The Art of Living	https://theconvivialsociety.substack.com/	183
Weird Ruby: The Double Aliased Enumerable Method	https://metaredux.com/	185
ASLRn't: How memory alignment broke library ASLR	https://zolutal.github.io/	187
Toby Fox's Interview with Kikiyama (2023)	https://chartcarr.neocities.org/	188
Best Practice of Figma for Indie Hackers	https://rene.wang/	189
The AGI Race Between the US and China Doesn't Exist	https://evabehrens.substack.com/	191
The Ugly Business of Monetizing Browser Extensions (2023)	https://mattfrisbie.substack.com/	192
How HEAD works in Git	https://jvns.ca/	193
JavaScript was slowing me down. All in on Elixir	https://pando.beehiiv.com/	194
Carrot Disclosure – Remote Code Execution in RaspAP	https://dustri.org/	195
Comparing Raw Asp.net Request Throughput Across Versions	https://weblog.west-wind.com/	196
Making an Emperor Bed (2018)	https://www.middleendian.com/	197
Designing Serverless Stream Storage	https://blog.schmizz.net/	198
Unpacking Elixir: Phoenix	https://underjord.io/	199
The Slow Web (2012)	https://www.jackcheng.com/	200
Ultrapacking: A Layer over Bit-Packing	https://save-buffer.github.io/	201
Yadm: Yet Another Dotfiles Manager	https://yadm.io/	202
Compiling Rust for .NET – Stack Unwinding, ARM and CIL Trees	https://fractalfir.github.io/	203
The Amazon Machine	https://www.ben-evans.com/	204
I Want Whatever the BLS Is Smoking	https://innovationnation.blog/	205
Stupid Simple Spellcheck	https://elijahpotter.dev/	206
Coroutines in JavaScript for web components	https://lorenzofox.dev/	207
A Close Up Look at the Consumer Data Broker Radaris	https://krebsonsecurity.com/	208
Running Out of Excuses	https://davidgorski.substack.com/	209
The Crypto Dysfunctional Map	https://didierpironi.bearblog.dev/	210
Debt Free – Tyler Tringas	https://tylertringas.com/	211
Become a Wikipedian in 30 minutes (video and transcript)	https://blog.mollywhite.net/	212
Post-Open License: First Draft – Bruce Perens	https://perens.com/	213
Why is everybody talking about Groq?	https://www.zach.be/	214
Acquired in 99 Days	https://austinhenley.com/	215
Four new models that are benchmarking near or above GPT-4	https://simonwillison.net/	216
How is this blog built?	https://andreabergia.com/	218
Go run vs. compile time dependency injection	https://breadchris.com/	219
Will Generation Z usher in the next corporate Renaissance?	https://stephanieschott.substack.com/	220
Why Tolkien Hated Dune	https://whitherthewest.com/	221
"I am to human consideration what the generated images are to actual sandwiches"	https://robhorning.substack.com/	222
Great Products Have Great Premises	https://www.workingtheorys.com/	223
The Case Against Embed Links	https://jackfaller.xyz/index	190
Working on the Road	https://www.urbancommuter.net/	184
How many political parties rule Canada? Fun with statistics	https://lemire.me/blog/	217
Biohacking: Cold Shower Therapy and Ritual	https://www.madewithtea.com/	224
On Async Rust	https://hugotunius.se/	225
Digital Dilemmas Around Sustainability: Why Bitcoin Not GenAI	https://efipm.medium.com/	226
The digital revolution has failed	https://disconnect.blog/	227
How to Overcome Your Fear of Failure: The Bucky Method	https://taylorpearson.me/	228
Embracing Modularity with Meson (2020)	https://brennan.io/	229
Book Review: San Fransicko (2022)	https://www.astralcodexten.com/	230
Copy and Micropatch: Writing Binary Patches in C with Clang Preserve_none	https://www.philipzucker.com/	231
I Tried the Apple Vision Pro	https://candrewlee14.github.io/	232
Xmake adds cosmocc toolchain support	https://tboox.org/	233
Imitation, Innovation, and Heresy in the Digital Public Square	https://read.lukeburgis.com/	234
Impostor Syndrome vs. the Dunning-Kruger Effect	https://raptori.dev/	235
The forbidden railway: Vienna – Pyongyang	https://vienna-pyongyang.blogspot.com/	236
The quiet, pervasive devaluation of front end	https://joshcollinsworth.com/	237
YX Problem	https://www.sicpers.info/	238
What high-performance language to learn [for bioinformatics]?	https://lh3.github.io/	239
How I use Git worktrees	https://notes.billmill.org/	240
Capable Leaders Navigate Uncertainty and Ambiguity	https://cutlefish.substack.com/	241
Everything Easy Is Hard Again	https://frankchimero.com/	242
On the Origin of Fuck	https://solongasitswords.wordpress.com/	243
Moore's Law vs. Duck Typing (2010)	https://tomforsyth1000.github.io/	244
Hacker's Guide to Neural Networks	https://karpathy.github.io/	245
How do you make an addictive video game?	https://pjvogt.substack.com/	246
Early Access to O'Reilly Media ActivityPub Book – Evan Prodromou's Blog	https://evanp.me/	247
I Hire Great Engineers	https://thedailydeveloper.substack.com/	248
Build Initramfs Rootless	https://blog.izissise.net/	249
Make your own Email server – FreeBSD, OpenSMTPD, Rspamd and Dovecot included	https://it-notes.dragas.net/	250
Software Development Bumper Sticker Practices (2009)	https://marxsoftware.blogspot.com/	252
The role of enterprise architect and principal engineer	https://ianrogers.uk/	253
I no longer maintain my Emacs projects on Sourcehut	https://protesilaos.com/	254
"No way to prevent this" say users of only language where this regularly happens	https://xeiaso.net/	255
No more blurry fonts in Linux	https://blog.aktsbot.in/	256
A Deep Dive into the Underlying Architecture of Groq's LPU	https://codeconfessions.substack.com/	257
Solar Storm Rendering	https://jakubtomsu.github.io/	258
Extreme Value Statistical Process Control	https://two-wrongs.com/	259
3D Printing: A High Temp Gelcast Ceramic Hot End	https://voxleone.com/	260
jorge: A personal site generator with org-mode support	https://jorge.olano.dev/	261
Affordable Wheel Based Refreshable Braille Display	https://jacquesmattheij.com/	262
Making Friends with AttributeGraph	https://saagarjha.com/	263
Advice for MBA students who want to be PMs	https://amitkumar.blog/	264
The Floppy Disk – By Bradford Morgan White	https://www.abortretry.fail/	265
On sugar-surge marketing – OnlineOrNot Diaries 19	https://maxrozen.com/	266
Pleasant Debugging with GDB and DDD	https://begriffs.com/	267
Browser Extensions: Powerful and Potentially Dangerous	https://textslashplain.com/	268
Game 505: Wizard's Tower (1982)	https://crpgaddict.blogspot.com/	269
A year in the life of a Playdate game developer	https://blog.gingerbeardman.com/	270
Managing Lockheed's Skunk Works	https://www.freaktakes.com/	271
Ignore All Web Performance Benchmarks, Including This One	https://blog.miguelgrinberg.com/	272
Map Memories to Web Pages	https://mmap.page/	273
What I've Learned About Apple's Spatial Video	https://blog.mikeswanson.com/	274
A Primer on Randomness	https://espadrine.github.io/	275
Why the political clock is ticking for TikTok	https://www.natesilver.net/	276
RAII All the Things	https://biowpn.github.io/	278
Building on quicksand – the state of modern AI app development	https://generatingconversation.substack.com/	279
How to troubleshoot deferred probe issues in Linux	https://blog.dowhile0.org/	280
Grats: A More Pleasant Way to Build TypeScript GraphQL Servers	https://jordaneldredge.com/	281
Why small developers are getting squeezed out of the housing market	https://www.noahpinion.blog/	282
Dynamic Printf Debugging with GDB	https://abstractexpr.com/	283
More on Handwriting and Cursive	https://brianschrader.com/	284
The Zeigarnik Effect (2013)	https://blog.sandglaz.com/	285
Power Laws in Culture	https://dougshapiro.medium.com/	286
Towards a standard for bearer token URLs	https://neilmadden.blog/	287
Interview Feedback to an Upcoming Computer Science Student	https://andrewrondeau.com/	288
Hyperinflation: Why a Dollar Crash Is Coming	https://kylebenzle.medium.com/	289
Look for Billion Dollar Mistakes	https://philosophicalhacker.substack.com/	290
The TikTok Ban and the Openness Trap (2020)	https://unintendedconsequenc.es/	291
On job-hunting in 2024 as a machine learning engineer	https://acompa.net/	292
Is IEEE floating-point math deterministic? Yes and no	https://randomascii.wordpress.com/	293
How to fix a bad user interface	https://www.scotthurff.com/	294
Hello. Happy Anniversary Macintosh	https://hardcoresoftware.learningbyshipping.com/	295
Provenance and Censorship	https://aiascendant.substack.com/	296
Startup founders will be 90% wrong about their assumptions	https://www.zaxis.page/	299
Proverbs (ie some advice on coding)	https://liampulles.com/	300
Neural Chess	https://pvdz.ee/weblog	297
High Agency	https://suryad.com/	301
The reason text-to-SQL will fail	https://davidsj.substack.com/	302
No More Forever Projects	https://dianaberlin.com/	303
Sight-Reading a Software Project	https://blog.charliemeyer.co/	304
How the Great Green Wall is holding back the Sahara desert	https://kottke.org/	305
"AI, no ads please": 4 words to wipe out $1T	https://12challenges.substack.com/	306
There's Plastic in My Plaque	https://erictopol.substack.com/	307
Lies, Damned Lies, and Uber	https://pluralistic.net/	308
On Authenticity and What's Worth Doing	https://ludic.mataroa.blog/	309
To Infinity Streams in PyFL	https://billwadge.com/	310
The 7 Types of Generative AI Products	https://eshanagarwal.substack.com/	311
Logical consistency is a social burden	https://ykulbashian.medium.com/	312
I've implemented the command I keep typing all day: gti	https://r-wos.org/	313
Clojure: The REPL makes contributing to open source easy	https://andersmurphy.com/	314
Signs that a Startup is Going Bad (2023)	https://www.swyx.io/	315
Food by mouth, again, but blended, and with an impaired ability to taste	https://jakeseliger.com/	316
Wikipedia over DNS (2008)	https://dgl.cx/	317
Albania accelerating its EU accession by 5 years thanks to AI	https://www.karlsnotes.com/	318
The Bradford Factor: A formula for employee dissatisfaction	https://ludditewithakeyboard.substack.com/	319
Making Powerline Ethernet Faster	https://moral.net.au/	320
There Are No Dangerous Thoughts, Thinking Itself Is Dangerous	https://www.falltide.com/	321
Optimizing Rabin-Karp Hashing	https://mattsills.github.io/	322
Show HN: Enabling containers to access the GPU on macOS	https://sinrega.org/	323
Understanding Meditation	https://aslanvacon.substack.com/	324
Low-quality studies mean meta-analyses are frequently worse than single studies	https://www.cremieux.xyz/	325
How to choose a better name for a variable	https://igorstechnoclub.com/	326
Proven Complexity and Technology Choice	https://www.fosskers.ca/	327
On Picking Side Projects	https://www.florianbellmann.com/	329
Why Windows Is Terrible	https://www.willghatch.net/	330
I'm a Programmer and I'm Stupid	https://antonz.org/	331
NoteCalc 0.4.0	https://bbodi.github.io/	332
What if we rotate pairs every day?	https://martinfowler.com/	334
Downpour is the game creation tool I have been working on for the past few years	https://v21.io/	335
Why Batch Norm Causes Exploding Gradients [2020]	https://kyleluther.github.io/	336
Trying to Understand Copilot's Type Spaghetti	https://rtpg.co/	337
The Effect of Front-End Vehicle Height on Pedestrian Death Risk [pdf]	https://www.justintyndall.com/	338
Towards zero-downtime upgrades of stateful systems	https://stevana.github.io/	339
Scalable CSS	https://chriscoyier.net/	341
Software Architecture, in Practice	https://blogs.newardassociates.com/	342
On the Rewards of Friendship in a World Obsessed with Romance (2014)	https://www.themarginalian.org/	344
The Life of an Ollama Prompt	https://eli.thegreenplace.net/	345
Surge Pricing Wouldn't Have Worked for Wendy's	https://rackhouse.substack.com/	346
The CAP theorem. The Bad, the Bad, & the Ugly	https://blog.dtornow.com/	347
FreeBSD has a(nother) new C compiler: Intel oneAPI DPC++/C++	https://briancallahan.net/	348
Where in the World Is Static Shock for GBA?	https://techsquidtv.com/	349
Matryoshka Representation Learning (MRL) from the Ground Up	https://aniketrege.github.io/	351
Signs you're about to be acquired (2020)	https://yolken.net/	352
Adding weight to drag and drop in macOS Finder	https://www.pbt.dev/	353
An email regex for reasonable people	https://colinhacks.com/	354
Minuteman Weapon System History and Description (2001) [pdf]	https://minutemanmissile.com/	355
Going Full-Time on Instapaper	https://bthdonohue.com/	356
If we must, let's talk about safety (2022)	https://cor3ntin.github.io/	357
The art and history of lettering comics	https://kleinletters.com/	358
Techniques to Break Words	https://adrianroselli.com/	359
The Rebalancing of Design Management	https://capwatkins.com/	360
On Claude 3.0	https://thezvi.substack.com/	361
Show HN: Easy file exchange between PC and phone	https://dusted.dk/	362
The Platinum Rule	https://effectiviology.com/	363
What is Diátaxis and should you be using it with your documentation?	https://idratherbewriting.com/	364
Making Make a Readme	https://www.dannyguo.com/	365
Movie Posters	https://worldspiritsockpuppet.com/	366
Literally Violence	https://www.infinitescroll.us/	367
Aboriginal Linux	https://landley.net/	368
An Unfamiliar World, 21st Century's problem with population decline	https://www.ecosophia.net/	369
Some Productivity Metrics Are Evil	https://markozivanovic.com/	370
Truth in the Age of Mechanical Reproduction	https://taggart-tech.com/	371
Dysfunctional Options Pattern in Go	https://rednafi.com/	372
Optimization Example: Mandelbrot Set Part 2 – up to 130x speedup	https://www.orange-kiwi.com/	373
Alert on Symptoms, Not Causes	https://varoa.net/	374
Response to Intrusion Into Waiting Lines (1986)[pdf]	https://dimnaut.info/	375
The Law of Leaky Abstractions (2002)	https://www.joelonsoftware.com/	376
How to keep building your engineering skills as a CTO	https://kaiomagalhaes.com/	377
You Don't Need a Dedicated Cache Service – PostgreSQL as a Cache (2023)	https://martinheinz.dev/	378
Show HN: Kalim – A Simple Place to Write	https://kalim.co/explore	343
On being a ‹insert favorite technology here› "guy"	https://sean.voisen.org/	379
Your Product Isn't That Important	https://umagp.com/	381
On Being Faceless	https://scottaaronson.blog/	382
Mystery Languages (2018)	https://blog.brownplt.org/	383
How to Travel Through Time	https://iyimide.vercel.app/	384
You're Always Carrying a Cannon	https://phildini.dev/	385
Show HN: Forest Watch	https://koenvangilst.nl/	386
Show HN: Arabic Virtual Keyboard	https://selmetwa.github.io/	387
Advice to Young People, the Lies I Tell Myself	https://jxnl.github.io/	389
Www.thug.com	https://nickdrozd.github.io/	390
Makefile hacks: print the value of any variable (2010)	https://blog.melski.net/	391
A Minimalist MIDI Synth with Sine Waves	https://massimo-nazaria.github.io/	392
The Doctrine of Relentless Utility	https://rogermartin.medium.com/	393
Disruption is different with AI (& more dangerous for incumbents)	https://gmays.com/	394
ADSL over Wet String	https://www.revk.uk/	395
Making the Monty Hall problem weirder but obvious (2021)	https://dynomight.net/	396
Exploring script, scriptlive, scriptreplay: Terminal Magic	https://www.zadmin.bzh/	397
Don't Over-Optimize Your Tools	https://dontbreakprod.com/	398
Serverless Maps for Fun and Profit	https://tobilg.com/	399
Boomer NIMBYs vs. Zoomer NIMBYs	https://www.maximum-progress.com/	400
Distributed SQLite: Paradigm shift or hype?	https://kerkour.com/	401
Make (2015)	https://www.ploxiln.net/	402
Out of Control	https://kk.org/	403
Enabling Constraints	https://jordankaye.dev/	404
How much effort is it to create software?	https://www.bitecode.dev/	405
`Keyword.get` Considered Harmful	https://lakret.net/	406
Mastering Atomic Complex Operations in Redis	https://nullonerror.org/	407
A Method for Doing Research	https://felipefarinon.com/	408
I'll probably be (relatively) poor soon	https://memoirsandrambles.substack.com/	410
APL and Syntax (2022)	https://blog.dhsdevelopments.com/	411
Comments Are Code (2018)	https://responsibleautomation.wordpress.com/	412
Stop using vsts-NPM-auth, it may be a 0-day	https://cyrs.substack.com/	413
Putting Privacy Focused "Free Speech" VPS Providers to the Test	https://crippled.media/	414
Sysadmin warstories: Sometimes the dam breaks even after plenty of warnings	https://rachelbythebay.com/	415
How to Structure C Projects: These Best Practices Worked for Me	https://www.lucavall.in/	416
Full-Bleed Layout Using CSS Grid	https://www.joshwcomeau.com/	417
Truth, Status, and Tribes	https://eriktorenberg.substack.com/	418
Setting a World Record: 200 days, 200 ultramarathons and 6,400 miles later	https://www.candiceburt.com/	419
Autogenerating a Book Series from Three Years of iMessages	https://benkettle.xyz/	420
How to hire a software engineer: a panellist's guide to the technical interview	https://pierreprinetti.com/	421
Telling a Story and Making a Point	https://clauswilke.com/	422
Reward Systems Can Localize the Fight Against GHG Emissions	https://sjweing.bearblog.dev/	423
Control, in Itself, for You	https://valand.dev/	424
Questions that will make you a rubber duck	https://blog.danslimmon.com/	425
Using accesskey attribute in HTML forms and links (2006)	https://jkorpela.fi/	427
PagerDuty (and OpsGenie) Alternatives – The Pragmatic Engineer	https://blog.pragmaticengineer.com/	429
Why do people spend time learning?	https://brettcvz.com/	431
Yet another terrifying predatory mosasaur from Morocco	https://www.nicklongrich.com/	432
Post-Open: Towards a Software Commons	https://openpath.chadwhitacre.com/	434
When robustly tolerable beats precariously optimal (2020)	https://www.askell.blog/	435
Bad API design costs a lot of money. In payments, it's clear why	https://news.alvaroduran.com/	436
Detailed Oriented or Just Bikeshedding?	https://andrewpaxson.com/	437
A conversation with Anthropic's Claude 3 Sonnet	https://facsimiletwo.substack.com/	438
The Pro-Israel Information War	https://www.leefang.com/	439
Donald Knuth – The Patron Saint of Yak Shaves (2017)	https://yakshav.es/	440
There's more to mathematics than rigour and proofs (2009)	https://terrytao.wordpress.com/	441
Do I Need a Consultant, Contractor or Employee	https://jacobian.org/	442
The C language is purely functional	https://conal.net/	443
The propagation of error in classical geometry constructions (2018)	https://jdh.hamkins.org/	444
Compressing CS2 Demos	https://healeycodes.com/	445
Ironies of Automation (1983) [pdf]	https://ckrybus.com/	446
Building with nightly Swift toolchains on macOS	https://oleb.net/	447
You Can Easily Delay Climate Change Today: SO2 Injection	https://unchartedterritories.tomaspueyo.com/	448
Libertarianism as Deep Multiculturalism	https://www.overcomingbias.com/	449
Teaching writing to the haters (2017)	https://sibilantfricative.wordpress.com/	451
Training LLMs from ground zero as a startup	https://www.yitay.net/	452
Why Do People Talk About Skiing So Much?	https://dominicdb.substack.com/	453
Roaring Bitmaps: What they are and how they work (2022)	https://www.vikramoberoi.com/	454
How to speed up the Rust compiler in March 2024	https://nnethercote.github.io/	455
Let's build a VORON Trident	https://www.jonashietala.se/	531
Planes, Ferries and Automobiles: How I Hacked Free Travel Across Iceland	https://www.debug.is/	456
Elinor Ostrom, the commons problem and Open Source (2009)	https://corte.si/	457
Apples, Oranges, and Normalized Hurricane Damage	https://rogerpielkejr.substack.com/	458
Gemini Advanced is not that advanced	https://www.understandingai.org/	460
What to do about children with obesity?	https://juliabelluz.substack.com/	461
The problem with SQL servers licensing costs	https://www.brentozar.com/	462
Campus Deplatforming: A Data Bonanza	https://greglukianoff.substack.com/	463
The Evolution of the Executive Team	https://www.edbatista.com/	465
Leadership Is a Skill	https://jakobwolman.medium.com/	467
What a startup does to you. Or: A celebration of new life (2012)	https://longform.asmartbear.com/	468
Building an Android App from the Command Line	https://www.hanshq.net/	469
Writing a storage engine for Postgres: an in-memory Table Access Method	https://notes.eatonphil.com/	470
Mite: A Mite-Y Language for the Web	https://csjh.blog/	471
Fourays: Updating Firmware and Debating Hardware Design (retro synth design)	https://doug.lon.dev/	472
It's time to give up on everything but email	https://manuelmoreale.com/	474
Using MAME's Lua integration for better retro dev	https://www.mattgreer.dev/	475
Cloud infrastructure that proposes verifiable bugfixes	https://lfdepombo.com/	476
ChatGPT generates illustrations for a few books, TV shows and movies	https://mitchw.blog/	477
Security Implications of Golang Net/Textproto.Reader Misuse	https://nowotarski.info/	478
Introduction to Mad Prompts: Copilot for Security Is a Blank	https://rodtrent.substack.com/	479
Control Commabody with an Oculus	https://vivekaithal.co/	480
A Homelab Dashboard for NixOS	https://jnsgr.uk/	481
The "missing" graph datatype already exists. It was invented in the '70s	https://tylerhou.com/	482
Having Fun with (Franken)PHP	https://labs.davlgd.fr/	483
The Impact of Pre-Allocating Slice Memory on Performance in Go	https://oilbeater.com/	484
A different approach to VR by Philip Rosedale	https://philiprosedale.substack.com/	485
Building Blog Post Recommendations Using LangChain	https://ishan.page/	486
The Builder's Guide to Better Mousetraps	https://brooker.co.za/	487
Who Am I? Conditional Prompt Injection Attacks with Microsoft Copilot	https://embracethered.com/	488
Buying the Dip	https://reedmolbak.substack.com/	489
Simsim Pendant	https://mitxela.com/	490
This Is Knuth 3:16 (2002)	https://www.larry.denenberg.com/	491
Fixing Diverged Branches	https://wizardzines.com/	492
"The Nature of Technology" – Book review	https://asindu.xyz/	494
Kagi and Wolfram	https://blog.kagi.com/	495
Was the Windows Registry a Good Idea? (2007)	https://blog.codinghorror.com/	496
How to generate uniformly random points on n-spheres and in n-balls	https://extremelearning.com.au/	497
Day 6/10: the words I never thought I would hear (about Hiragana practice)	https://webiphany.com/	498
Walking Phoenix	https://walkingtheworld.substack.com/	499
Linear Regression for Fun and Profit (2012)	https://www.evanmiller.org/	500
Why People React Less Positively to Research Favoring Men	https://www.stevestewartwilliams.com/	501
Secrets of XProtectRemediator	https://alden.io/	502
Parkinson's Law: It's Real, So Use It	https://theengineeringmanager.substack.com/	503
Component Testing with Safetest vs. Cypress vs. Webdriverio	https://bromann.dev/	504
Bits of Unsolicited Advice by Kevin Kelly	https://www.neil.blog/	505
Can your storage alert you to cyber attacks in under a minute? IBM FlashCore can	https://barrywhytestorage.blog/	507
Major service outage reported: You're lucky if you see this message	https://dewmal.medium.com/	508
Applying lessons from Pixar Brain Trust to improve how we solve problems	https://makingsmallercircles.com/	509
500 Days in Amsterdam Without a Bike: A Journey of Mind, Body, and City	https://www.mathys.to/	510
Machiavelli I – S.P.Q.F. (Begins Machiavelli Series) (2012)	https://www.exurbe.com/	511
Is $100M Enough?	https://steveblank.com/	512
Feature flags are ruining your codebase	https://zaidesanton.substack.com/	514
Flat bands: Why you might care, and one way to get them (2022)	https://nanoscale.blogspot.com/	515
"AI" and accessible front-end components: is the nuance generatable?	https://hidde.blog/	516
Writing Software with Infinite Money	https://fruty.io/	518
Mix Math and Morality in Moderation	https://superbowl.substack.com/	519
Grep Britain: visualise cities, towns, villages and hamlets	https://conradgodfrey.com/	520
My Rule of the 6 Spheres	https://www.honest-broker.com/	521
I Explored My Z Shell History	https://jerrynsh.com/	522
LibraryBox	https://jasongriffey.net/	523
Facing reality about the EU is a core requirement for good management	https://www.baldurbjarnason.com/	525
Is Azure DevOps "Dead"?	https://www.bensampica.com/	526
Prodzilla: From Zero to Prod with Rust and Shuttle	https://codingupastorm.dev/	527
Google Demands That We Censor Our Content	https://www.nakedcapitalism.com/	528
The Five Top (2013)	https://seths.blog/	529
Transformers Optimization: Part 1 – KV Cache	https://r4j4n.github.io/	530
Exploring developer experience with PHP, public APIs, and beer	https://joeymckenzie.tech/	473
I won't build that (dear customer)	https://willem.com/en/	513
Aggregator's AI Risk	https://stratechery.com/	532
First Year in Chronicling Commits	https://beccais.online/	533
Credit Your GenAI	https://blog.erlend.sh/	534
Generating a 3D map with OpenStreetMap and A-Frame	https://mary.codes/	535
Logic (1984)	https://www.ditext.com/	536
You can even teach it to play Mahjong: Claude 3 leads GPT4 across the board	https://zhlmmc.medium.com/	539
Protecting paths in macro expansions by extending UTF-8	https://nullprogram.com/	540
Rational Interpolation	https://wordsandbuttons.online/	541
Generative AI vs. AWS Textract – A Case for GPT Wrappers	https://domluna.com/	542
To be held accountable, you need the authority to make decisions	https://www.leadinginproduct.com/	543
Self hosting a Copilot replacement: my personal experience	https://www.andreagrandi.it/	544
Understanding the YUV Image Format	https://juraobjc.com/	545
Nightmare on Lemmy Street (A Fediverse GDPR Horror Story)	https://tech.michaelaltfield.net/	546
Building Reactive Systems with Event-Based Architecture	https://nrempel.com/	547
Playing Around with Ollama for Local LLM	https://nathanleclaire.com/	548
A moment of financial clarification (2013)	https://whatever.scalzi.com/	549
Why Does 'Is-Number' Package Have 59M Weekly Downloads?	https://shubhamjain.co/	550
EmailOctopus SDKs for PHP and Laravel	https://geoligard.com/	551
A Cloud-Scale Characterization of Remote Procedure Calls	https://newsletter.micahlerner.com/	552
Dropcap Generation with AI	https://gwern.net/	553
A Little Nix Fix	https://tommorris.org/	554
Welcome to the Age of the Late Bloomer	https://www.commonreader.co.uk/	555
A Refined Similarity-Based Bigram Model	https://demoriarty.github.io/	556
Mas: Multi-view Ancestral Sampling for 3D motion generation using 2D diffusion	https://guytevet.github.io/	557
Why F# is a fun programming language	https://hamy.xyz/	558
From Beeps to Toots: Reviving Pagers with Python and Mastodon	https://finnley.dolphinhome.net/	559
Cult Documentaries That Will Leave You Speechless	https://roybntz.medium.com/	560
Everything You Need to Know about NectarGPT, ChatGPT, AGI, Project Pollen, More	https://www.nectargpt.net/	562
On the Nature of Human Assembly	https://mflb.com/	563
Utf8lut: Vectorized UTF-8 Converter	https://dirtyhandscoding.github.io/	564
The Grand Reveal Violates the SaaS Business Model	https://shermanonsoftware.com/	565
My 40 Ingredients Forever	https://misterbranzino.substack.com/	566
Streaming chat completions using Phoenix LiveView	https://benreinhart.com/	567
Visualizing the ARM64 Instruction Set	https://zyedidia.github.io/	568
A Cloud-Scale Characterization of Remote Procedure Calls	https://www.micahlerner.com/	569
Blame Incentives for Delayed Family Formation	https://greyenlightenment.com/	570
An Interview with Maarten van Steen (English/Spanish)	https://camilocs.substack.com/	571
Using Namespaces with Git and SSH	https://locallytrivial.com/	572
Entrepreneur 101: increase your brain power	https://www.baby-cto.com/	573
My Dream Life as a Polish Prince	https://gideons.substack.com/	574
Rsync and Encrypted SSH Keys (2023)	https://erwin.co/	575
There Is No Moral Imperative to Be Miserable	https://mentalhellth.xyz/	577
The Harvard Body-Snatching Case, and the Economy of Human Remains	https://thethreepennyguignol.com/	578
Everything Standardized, Nothing Works	https://blog.domainmess.org/	579
Periodicity Transforms	https://sethares.engr.wisc.edu/	580
My Forthcoming Novel, and Why I Won't Write a Mental Illness Memoir	https://freddiedeboer.substack.com/	581
Why Is It So Hard to Build an Airport?	https://www.construction-physics.com/	582
For Starters #21: Swag Is for Paying Customers	https://forstarters.substack.com/	583
System design of a 3rd party API scraper with serverless	https://limmat.fun/	584
The Hardest Problem	https://benv.ca/	585
The Curious Case of Parallel Inventions	https://sahilist.substack.com/	586
Borrow checking without lifetimes	https://smallcultfollowing.com/	587
About HTML semantics and front-end architecture (2012)	https://nicolasgallagher.com/	588
Rendering Skies in WebGL	https://zvxryb.github.io/	589
GTPDOOR – A novel backdoor tailored for covert access over the roaming exchange	https://doubleagent.net/	591
Postgres Indexes, Partitioning and LWLock:LockManager Scalability	https://ardentperf.com/	593
Java is becoming more like Rust, and I am here for it	https://joshaustin.tech/	594
How to Pick a Career (That Fits You) (2018)	https://waitbutwhy.com/	595
Use weird tests to capture tacit knowledge	https://jmduke.com/	596
Central bank simulator game with a realistic economic model	https://benoitessiambre.com/	597
Do literally anything	https://aaronfrancis.com/	598
Hacky Spell Checking for Blog Posts	https://tudorr.ro/	599
Reverse-engineering my way to “Spotify Wrapped for your university meal plan”	https://ben.page/	600
Sincerely, John Hughes (2009)	https://wellknowwhenwegetthere.blogspot.com/	601
The hunt for the missing data type	https://www.hillelwayne.com/	602
Case-study: sharing home-cooked dinners	https://anonel.substack.com/	603
Reading JSON from a Rails API in Swift	https://calebhearth.com/	604
Playing with Infinity in CSS	https://codersblock.com/	605
Introduction to Low Latency Programming: Understand Storage	https://tech.davidgorski.ca/	606
Why enterprise IT is so complex	https://architectelevator.com/	607
Go 2022-2024 and beyond: Let's talk about AI	https://ajmani.net/	608
Establish a Folder for Instruction Manuals	https://practicalbetterments.com/	609
Dynamic Languages Are Static Languages	https://existentialtype.wordpress.com/	610
The Whitehouse report on adopting memory safety	https://shape-of-code.com/	611
Wendy's Flips on Dynamic Pricing	https://gadallon.substack.com/	612
Distillation with Linear Models	https://vladfeinberg.com/	613
Be in the desires market, not the solutions market (2020)	https://invertedpassion.com/	614
Anatomy of a NixOS Config	https://unmovedcentre.com/	615
Why the 100x analyst doesn't exist	https://mikkeldengsoe.substack.com/	616
How to use an Object Relational Mapper and never learn SQL	https://badsoftwareadvice.substack.com/	617
How can C Programs be so Reliable? (2008)	https://tratt.net/	618
Controlled Digital Lending: Publishers Against Library Books	https://blog.giovanh.com/	619
How to save datetimes for future events – (when UTC is not the right answer)	https://www.creativedeletion.com/	620
What Is Backward Error?	https://nhigham.com/	621
Server Actions in Fastify	https://hire.jonasgalvez.com.br/	622
Hard Is Not Defensible	https://www.alexcrompton.com/	623
How I decide if your website is worth a revisit	https://cd.is-a.dev/	624
List of 2024 Leap Day bugs	https://codeofmatt.com/	625
Make as a general purpose task runner	https://ivan.sh/	626
I built a self-serving advertisement solution for myself	https://fangpenlin.com/	628
The Long, Slow, Stupid, Fun Way	https://newsletter.pathlesspath.com/	629
Should you watch that recent movie?	https://www.emilkirkegaard.com/	631
A Global AppleTalk Network: Pushing AppleTalk Across the Internet	https://biosrhythm.com/	632
AI in Emacs	https://willschenk.com/	633
A Recipe for Auth Cookies in the Decoupled Front End and Back End Architecture	https://nowaycodes.substack.com/	634
Increase Your Luck	https://blog.simonfarshid.com/	637
Figma's Vector Networks	https://madebyevan.com/	638
Migrating from LSP-Mode to Eglot	https://andreyor.st/	639
How much CO2 could a country save by deleting their unused data?	https://markan.me/	641
Clothing Is a Virus	https://dkl9.net/	642
Use Git and GitHub in this way to better collaborate	https://tqmggmbloz.netlify.app/	643
Rolling your own PCIe 3.0 Bifurcation riser (2021)	https://www.mattmillman.com/	644
The fish shell is amazing (2021)	https://rmpr.xyz/	645
An Overview of Quantum Computing's Possible Impact on Cryptography	https://thomasbandt.com/	646
Removing GUI elements as the user's skill level increases	https://robhaisfield.com/	647
Show HN: A tool to generate personal messages for Twitter/X cold outreach	https://www.icebreaker.to/	648
What are GADTs and why do they make type inference sad?	https://blog.polybdenum.com/	649
Running CP/M on the C128	https://celso.io/	650
Motion blur all the way down (2022)	https://www.osar.fr/	651
Bring back private offices	https://albertcory50.substack.com/	652
French court issues damages award for violation of GPL	https://heathermeeker.com/	653
Gemini has a hidden option for "funnier" responses	https://www.ugu.rs/	655
Internet Evanescence	https://boehs.org/	656
Building a TUI system monitor with FINAL CUT	https://lorendb.dev/	657
What I like about Go	https://lu.sagebl.eu/	658
"Noah": Naturally Occurring Affordable Housing	https://www.granolashotgun.com/	659
GAI Is Going Well	https://grumpygrace.dev/	660
Enough with the dead butterflies (2017)	https://www.emilydamstra.com/	661
The Golden Age of Software	https://bscalable.com/	662
Building an infinite crafting game using LLMs and DALL-E	https://blog.sshh.io/	663
Sense, Reference, and "What Is a Woman?"	https://neonomos.substack.com/	664
Show HN: Free comments section for personal sites	https://blog.bhread.com/	665
Data format design is a UX issue	https://blog.ldodds.com/	666
The internet lost its shit over Wendy's 'surge pricing'	https://michaelestrin.substack.com/	667
How to be a good listener	https://tomblog.rip/	668
Safety Shouldn't Be Opt-In	https://knocte.blogspot.com/	669
CSS for printing to paper	https://voussoir.net/	670
What Liberal Arts Education Is For	https://innig.net/	671
Test Quality vs. Bashing TailwindCSS	https://mariohamann.com/	672
Aviation Safety Reporting System (1993)	https://yarchive.net/	673
The Case Against Geometric Algebra	https://alexkritchevsky.com/	674
TIL: How to unify all three of Ubuntu's clipboards	https://gurudas.dev/	675
Shirt whose price increases by 1€ with every purchase.The price is on the shirt	https://driesdepoorter.be/	676
Semi-automatic whole-house iPhone internet failover	https://calbryant.uk/	677
Reset Your Social Media Annually	https://www.bramadams.dev/	678
People’s Peace Treaty of 1971 (2021)	https://www.larrysworld.com/	679
Offloading JavaScript with Custom Properties	https://heydonworks.com/	680
How to Make NMAP Recognize New Services	https://shufflingbytes.com/	681
Why Sorry Dave?	https://sorrydave.substack.com/	682
The journey of a product support engineer	https://iviacharles.medium.com/	683
The Fog of War: or, when being vague is useful	https://blog.waleson.com/	684
I Guarantee You Haven't Seen These Humanoid Robots	https://james.darpinian.com/blog/	630
The hater's guide to Kubernetes	https://paulbutler.org/	685
Identity, authentication, and authorisation from the ground up	https://apuchitnis.substack.com/	686
Commitment Engineering	https://www.barry.ooo/	687
Getting sh-t done: simple, paper-based time management	https://utilware.com/	688
Storing binary data in playing cards (2014)	https://www.timwarriner.com/	689
A Wonky Experience	https://www.antipope.org/	690
How the YIMBY Movement Is Showing America a Way Forward	https://www.ryanpuzycki.com/	691
App Store and CloudKit Public Database	https://www.outcoldman.com/	692
AI Research in Feb 2024 – LoRA Successor, "Small" LLMs, Transparent LLM Research	https://sebastianraschka.com/	693
Sneaky React Memory Leaks: How useCallback and closures can bite you	https://schiener.io/	694
The Math of Card Shuffling	https://fredhohman.com/	695
My late discovery of C++'s std:filesystem	https://www.sandordargo.com/	696
Tests Are an Observability Concern	https://briankung.dev/	697
Observations of Leadership (Part One)	https://hazelweakly.me/	698
Mustard	https://chloelist.substack.com/	700
Writers can write anything. Programmers can't	https://www.mahendraker.com/	701
A kids' novel inspired me to simulate a gene drive on 86M genealogy profiles	https://worthdoingbadly.com/	702
The Rise and Fall of Giants?	https://rishad.substack.com/	704
Roaring Bitmaps	https://pncnmnp.github.io/	705
Writing an OS Kernel in Odin	https://bumbread.substack.com/	706
Topher's Breakfast Cereal Character Guide	https://www.lavasurfer.com/	708
Are Video Generation Models World Simulators?	https://artificialcognition.net/	710
Digital Relationships; or, How I Met My Wife and Why I Might Not Try That Again	https://old.starbreaker.org/	711
CSS Scroll-Triggered Animations with Style Queries	https://ryanmulligan.dev/	713
AI Is Bad/Good Actually	https://www.todepond.com/	714
The Case for IPv4.1	https://blog.lexspoon.org/	715
Factfulness: A Paradigm Shift in Perceiving the World	https://pooriat.com/	716
The Checklist Manifesto	https://atulgawande.com/	717
Building a simple load balancer: Part 1	https://hcrypt.net/	718
What Is WebTV?	https://goblin-heart.net/	719
I don’t think you should sign your Git commits	https://blog.glyph.im/	721
Using HTML Tags to Build Video Games	https://marak.com/	722
Quadratic Payments: A Primer (2019)	https://vitalik.eth.limo/	723
B19.SE Data Dumps: OPML	https://b19.se/	724
How to convert Node.js stream callback functions into an Async Iterator	https://www.jbernier.com/	725
A tale of Interface Smuggling in Go net/HTTP	https://mahesh-hegde.github.io/	726
Google Gemini's Woke Catechism	https://www.fromthenew.world/	727
The One Billion Row Challenge in Go: from 1m45s to 4s in nine solutions	https://benhoyt.com/	728
Copilot-Explorer – See what the Copilot extension sends to the server	https://thakkarparth007.github.io/	729
Megaparsec Tutorial	https://markkarpov.com/	730
Butchershop Economics	https://brainpickings.substack.com/	731
Eternal Bash History	https://tylercipriani.com/	732
Verified high-level synthesis – now with hyperblocks	https://johnwickerson.wordpress.com/	733
Too Many Embedded Logs? PureScript Might Help (Ox64 BL808 SBC / Apache NuttX)	https://lupyuen.codeberg.page/	734
Where is all of the Fediverse?	https://blog.benjojo.co.uk/	735
A whirlwind introduction to dataflow graphs	https://fgiesen.wordpress.com/	736
Git: Programmatic Staging	https://choly.ca/	737
First principles thinking vs. second order thinking	https://thevivekpandey.github.io/	738
Local Neovim Plugin Development	https://cj.rs/	739
How user groups made software reuse a reality	https://ztoz.blog/	740
Writing a scheduler for Linux in Rust that runs in user-space (part 2)	https://arighi.blogspot.com/	741
Journalism is Broken, but so is Alternative Media	https://unfashionable.blog/	742
The perils of pause(2) (2023)	https://www.cipht.net/	743
The Ten Commandments of Software Development	https://samuellawrentz.com/	744
Abstraction, intuition, and the "monad tutorial fallacy" (2009)	https://byorgey.wordpress.com/	745
Bookmarklet Generator	https://www.benjaminkeen.com/	746
Writing a Minecraft server from scratch in Bash (2022)	https://sdomi.pl/	747
Transcript of a strange call	https://yarmo.eu/	748
Managing R environments using conda	https://andrewpwheeler.com/	749
Reasons to Make Apache Iceberg and Dremio Part of Your Data Lakehouse Strategy	https://blog.datalakehouse.help/	750
Rescamming: A naughty Perl script delivers payback to some Facebook scammers	https://www.thran.uk/	751
Why I'm Sticking with Standard Notes	https://theprivacydad.com/	752
The Fascist Simulation	https://www.ianalanpaul.com/	753
In Depth Look at Action Mailbox	https://www.codynorman.com/	754
Broken Arrows	https://kg.dev/	755
Automating the publication of my Out of Ten reviews using Zapier and Notion	https://www.planetjones.net/	756
TableFlip v1.6.0: JSON Support and Font Resizing	https://christiantietze.de/	757
Why and how I build terrible things	https://andrew-quinn.me/	758
Recursion Viewer	https://dmytrobaida.github.io/	759
2x2 Games Will Change Your Life	https://wyclif.substack.com/	760
Amateur Radio Fatalism	https://ke9v.net/	761
How to Break into Silicon Valley	https://andrewchen.com/	762
My first impressions of Next.js	https://maged.com/	763
Use KeePassXC to sign your Git commits	https://code.mendhak.com/	764
Text UIs != Terminal UIs	https://aartaka.me/	765
Deploying fiber in the home	https://blog.daknob.net/	766
Work from the Solar System	https://amaca.substack.com/	767
R: Introduction to Data Science (2019)	https://rafalab.dfci.harvard.edu/	768
Don't Use Discord for FOSS (2021)	https://drewdevault.com/	769
Image Recycler	https://potch.me/	770
Mastering OpenTelemetry with Uptrace: A Developer's Guide	https://ecostack.dev/	771
Sequent Calculus as a Compiler Intermediate Language (2016) [pdf]	https://simon.peytonjones.org/	772
Getting files to and from a PowerBook 3400c with hfsutils	https://www.jeffgeerling.com/	773
A reactionary take on memory safety	https://lcamtuf.substack.com/	774
"Hello World" in Web Development	https://unplannedobsolescence.com/	775
Saved by NixOS Integration Tests, Surprisingly	https://boinkor.net/	776
Under the Microscope: Three Dirty Dwarves	https://32bits.substack.com/	777
K8s Service Meshes: The Bill Comes Due	https://matduggan.com/	778
Software engineering practices I like, in 2024	https://thetechenabler.substack.com/	779
Processing Inputs from the Internet	https://bagerbach.com/	780
The Myth of Scarcity and Its Threats to Human Society [pdf] (2023)	https://kemendo.com/	781
GPT-4's Hidden Cost: Is Your Language Pricing You Out of AI Innovation? (2023)	https://tomaszurbanski.substack.com/	782
How to not burn your SDI / HDMI Ports	https://souandrerodrigues.medium.com/	783
Apple Should Thank the Asahi Team and What Laptop Should I Get?	https://gigatexal.blog/	784
Front-end complexity is all in your head	https://bower.sh/	785
We've lost too many hackers to suicide. What if Satoshi was one of them?	https://evanhatch.medium.com/	786
Bret Victor	https://worrydream.com/	787
Cross Window Forgery: A Web Attack Vector	https://www.paulosyibelo.com/	788
The DevRel went down to Georgia	https://alex.party/	789
Surviving the Cookie Hell	https://blog.a21.dev/	792
Brain Pilots	https://breckyunits.com/	793
Python IAQ: Infrequently Answered Questions	https://norvig.com/	794
Understanding the terminology of logical reasoning in computer science (2024)	https://rbachmann.net/	795
Setting up Proxmox VE in terrible hardware: a home lab story	https://fell.pages.dev/	796
What Is a Series A?	https://magid.substack.com/	797
Language Modeling by Estimating the Ratios of the Data Distribution	https://aaronlou.com/	798
Leon Vynehall Is My Therapist	https://greed.observer/	799
When Did Popular Music Become Standardized? A Statistical Analysis	https://www.statsignificant.com/	800
Will Japan's Population Death Spiral?	https://nothinghumanisalien.substack.com/	801
The Rise of POMG, Part 4: A World for the Taking	https://www.filfre.net/	802
Go Enums Suck	https://www.zarl.dev/	803
Why isn't Amazon signing their emails? (2019)	https://www.arp242.net/	804
A Deep Dive into the Concept and World of Apache Iceberg Catalogs	https://blog.datalakehouse.tips/	805
10 Years of Building Open Source Standards: From Parquet to Arrow to OpenLineage	https://sympathetic.ink/	806
Banana Pivot: Unpeeled	https://blog.erikdunteman.com/	807
Building a Machine Learning Rig	https://tuananh.net/	808
Advanced Git commands every senior software developer needs to know	https://optimizedbyotto.com/	809
LLM-generated docs are usually worthless	https://blog.gnoack.org/	810
Snapshot Testing	https://avi.im/	811
Travel East from Seattle in a Straight Line. What Is the First Country You Hit?	https://finmoorhouse.com/	813
Celebrating dependency-management-data's first birthday	https://www.jvt.me/	814
We are a one-car family	https://odonnellweb.com/	815
The Case for Smaller Telescopes	https://journal.spencerwnelson.com/	817
(1) Escape the Ouroboros of BS – By Irene Kaoru	https://irenekaoru.substack.com/	818
Context Is King (2020)	https://letterstoanewdeveloper.com/	819
Zen in the Art of Beat Saber	https://jarbus.net/	820
PageSpeed Insights	https://www.robin.is/	822
My role in a courtroom drama over the identity of Satoshi Nakamoto	https://rorycellanjones.substack.com/	823
My Birthday Gangbang a slutistical breakdown(NSFW)	https://aella.substack.com/	824
If culture eats strategy for breakfast, OKRs are cheap juice everyone gulps down	https://asktheuxer.com/	825
Losing the Imitation Game (2023)	https://jenniferplusplus.com/	826
Where is Noether's principle in machine learning?	https://cgad.ski/	827
I accidentally deleted a bad game revision from MAME	https://www.mistys-internet.website/	828
12 Years at Meta	https://blog.vjeux.com/	829
FedCM: Sign-in-with-Big-Tech-Only or Sign-in-with-Whom-I-Prefer?	https://wrily.foad.me.uk/	830
Cloud Is Overkill	https://bittich.be/	831
Running new applications on old glibc	https://www.lightofdawn.org/	832
Simple Executable Love2D Files, Or, You Can Shove Random Data at the Start of A	https://artemis.sh/	833
Leap Year Test in K&R (2020)	https://susam.net/	834
Streaming HTML out of order without JavaScript	https://lamplightdev.com/	835
More Stupid LLM Tricks	https://ninazumel.com/	837
In Praise of Nushell	https://lars.yencken.org/	838
Reflections on My Eight-Year Career Journey	https://chughgpt.substack.com/	839
The "End of Programming" will look a lot like programming (2023)	https://ben11kehoe.medium.com/	840
Increasing IQ Is Trivial	https://morelucid.substack.com/	790
Socialism when I buy, Capitalism when I sell	https://shobhitic.com/	791
Synthetic Data for LLM Training	https://vaclavkosar.com/	841
Distributed Data for Microservices – Event Sourcing vs. Change Data Capture	https://murphye.medium.com/	843
Emacs: Watching YouTube with Yeetube and Mpv	https://michal.sapka.me/	844
On bad drug pricing research	https://www.writingruxandrabio.com/	846
Dotfiles Digest: Git	https://adrg.se/	847
Devil's Dictionary of Programming (2013)	https://programmingisterrible.com/	848
On time travel (Or: fact-checking and the dangers of science populism)	https://metanoias.substack.com/	849
Planned App-Solescence	https://dillonshook.com/	850
Holding Stationæry	https://occasionallycogent.com/	853
Experimenting with GC-less (heap-less) Java	https://maximullaris.com/	855
Pain We Forgot	https://www.scattered-thoughts.net/	856
Granular Private Data Is the Foundation of Targeted Advertising	https://pxlnv.com/	857
1000 Miles Steered by Drogue	https://sailorjames.medium.com/	858
GGUF, the Long Way Around	https://vickiboykis.com/	859
Understanding Propensity Score Weighting	https://livefreeordichotomize.com/	860
The Paradox of Diffusion Distillation	https://sander.ai/	861
0 to App Store in 60 days	https://campedersen.com/	862
CSS: Has() Interactive Guide	https://ishadeed.com/	863
Show HN: Fun with Flags (In Slack)	https://fragkakis.github.io/	864
Show HN: Instant 'Link-Site' HTML Generator	https://linkdave.xantasoft.com/	865
Password Reset for End-to-End Encrypted Applications (2020)	https://francoisbest.com/	866
Another reason to use offline-first architecture: Developer Experience	https://intuitably.com/	867
Introducing OneRepo: JS/TS monorepo toolchain for safe, strict, fast development	https://paularmstrong.dev/	868
AI and Design Systems	https://bradfrost.com/	869
Wes McKinney: The Road to Composable Data Systems	https://wesmckinney.com/	870
Will the digital euro be equivalent to cash?	https://blog.xot.nl/	871
Crazy crypto mining story from 2013	https://thelemonking.medium.com/	872
The Survival of the Friendliest?	https://www.conspicuouscognition.com/	873
Big Post About Big Context	https://gonzoml.substack.com/	874
The 29th, and Other Calendar Quirks	https://etiennefd.substack.com/	875
Cypherpunks, Mixmaster, and Mixminion: Anonymous Email	https://elly.town/	876
On Getting Paid for Open Source	https://radekmie.dev/	877
February Roundup	https://tomhipwell.co/	878
The art of reusable React components feat. TWC	https://manupa.dev/	879
Falsehoods programmers believe about time	https://infiniteundo.com/	880
The Descent to C	https://www.chiark.greenend.org.uk/	881
Managing Gmail Configuration for Labels and Filters as Code	https://nami.land/	882
Generating beautiful terminal outputs for READMEs	https://blog.ajhenry.com/	883
We attended our first trade show as indie game dev, here's what happened	https://indieklem.com/	885
I looked out the window and saw it was grey outside	https://jspann.me/	886
Vim Game of Life	https://normalmo.de/	887
Russia's Nesting Satellite Problems	https://illdefinedspace.substack.com/	888
The Linux CNA – Red Flags Since 2022	https://jericho.blog/	889
Billionaire-Fueled Lobbying Group Behind the State Bills to Ban UBI Experiments	https://www.scottsantens.com/	890
Themescura: Better tools for user-facing customizations	https://www.xypnox.com/	891
The novice and the master: 5 programming jokes	https://www.piglei.com/	892
Data Longevity and Civilization's Demise	https://tevinzhang.com/	893
Uninterupted Desktop Streaming vs. NetworkManager	https://rubin55.org/	894
Idempotency – what is it, and how can it help our Laravel APIs?	https://www.conroyp.com/	895
Securing Kubernetes: Avoiding Hard-Coded Passwords in Manifests and Helm Charts	https://vahid-r.com/	896
Converting an Image into ASCII Art Masterpiece (2017)	https://www.jonathan-petitcolas.com/	897
A Stick Figure Guide to the Advanced Encryption Standard (AES)	https://www.moserware.com/	898
React Strict DOM	https://szymonrybczak.dev/	899
How to Build AWS-Compatible APIs: AWS Sigv4	https://www.aspiring.dev/	900
Where's the Perfect Domain Registrar?	https://jlelse.blog/	901
Galois field in auto factory: the making of QR codes	https://static.chunichi.co.jp/	902
Curvature of Polyhedra (2021)	https://nicf.net/	903
NewsHavn: Danish news, in English (translated by LLM)	https://duarteocarmo.com/	904
Tetris	https://www.colinfahey.com/	905
Computers I've Known and Loved	https://www.bogpeople.com/	906
NASA Inspector General: Mars Sample Return Mission in Big Trouble	https://behindtheblack.com/	907
Starlink terminal revision 4: overview and tests	https://olegkutkov.me/	908
Command Line Faxing (2014)	https://www.petekeen.net/	910
I keep making things out of checkboxes (2021)	https://www.bryanbraun.com/	911
Put a date on your blog post (2014)	https://www.observationalhazard.com/	912
Decide bad decide good? Evaluating decision quality in evaluation-easy domains	https://danluu.com/	913
How well can AI imitate an early modern doctor?	https://resobscura.substack.com/	914
A Hymn to Hot Sauce	https://joshuadolezal.substack.com/	915
Boundaries Are in the Eye of the Beholder	https://planktonvalhalla.com/	916
The Unexpected $30k Benefit of the Pandemic: Haircuts	https://www.dquach.com/	917
Mixing Games and Applications [pdf]	https://lostgarden.home.blog/	851
How to Fork Algorand's Pure Proof-of-Stake Blockchain	https://www.zach.be/	852
Avoiding Hydration Mismatches with UseSyncExternalStore	https://tkdodo.eu/blog	854
Re: You can't be a good .NET developer (2016)	https://ayende.com/blog/	909
Performance Comparisons of Common Operations	https://www.mikeash.com/	918
We could make our homes easier to decarbonise by using tech called a "database"	https://takes.jamesomalley.co.uk/	919
Bitcoin Is Mostly Worthless	https://ajit.dhiwal.com/	920
What Does Perlin Noise Sound Like?	https://gpfault.net/	921
Music Journalism May Have to Write Its Own Obituary for Free	https://zacharylipez.ghost.io/	922
Conspiracy Theorists Aren't Ignorant. They're Bad at Epistemology	https://benthams.substack.com/	923
Children need risk, fear, and excitement in play	https://www.afterbabel.com/	924
Draw is now Open Source (2020)	https://rudyfaile.com/	925
Historical facts I consistently forget	https://milan.cvitkovic.net/	926
Serverless ClickHouse Cloud – ASDS Chapter 5 (part 1)	https://jack-vanlightly.com/	927
We Need the Men	https://edgeofpractice.substack.com/	928
Thoughts on Cursor.sh as a Neovim User	https://www.al3rez.com/	929
Beyond the beep and saving sleep: optimizing the On-Call experience	https://scalex.dev/	930
Exists Is the Enemy of Good	https://seancoates.com/	931
OpenCollective Shutting Down	https://daniel-lange.com/	932
Sudo on Windows – A Quick Rundown	https://www.tiraniddo.dev/	933
Which companies will win the AI race? Those with Loop Control	https://ealpha.substack.com/	934
Choosing to Have Kids During the End Times	https://www.georgesaines.com/	935
Show HN: Ambient ScotRail Beats	https://www.matteason.co.uk/	936
55 Burgers, 55 Fries – The Terrible Impact of Pay It Forward Trains	https://divingintheshallowend.com/	937
What Is Sustaining Engineering?	https://blog.janiuk.se/	938
Show HN: My journey in kernel dev so far	https://blog.retpolanne.com/	939
Writing a Fast Compiler	https://tibleiz.net/	940
Climbing a mountain to meet an old man	https://mattd.substack.com/	941
The Roguelike Rule of Thumb	https://synystron.substack.com/	942
How Video games use LUTs and how you can too	https://blog.frost.kiwi/	943
The "Not All Scotsman" Fallacy	https://superduperg.substack.com/	944
HubSpot app marketplace by the numbers – independent product demand and earnings	https://claytonfarr.com/	945
Safeguarding changes using update plans	https://tn1ck.com/	946
Writing an OLED display driver in MicroZig	https://andrewconl.in/	947
All you need is links (2022)	https://subconscious.substack.com/	948
The Tech Industry Doesn't Understand Consent – Opt-Out Is Not Consent	https://soatok.blog/	949
Delete, delete, delete: the ultimate productivity hack – Matt Sgarlata's blog	https://mattsgarlata.com/	950
Git add --patch and --interactive	https://nuclearsquid.com/	951
Browser-based robot dog simulator: walking controller (2023)	https://grgv.xyz/	952
Lessons from Optics, the Other Deep Learning (2018)	https://www.argmin.net/	953
Shipping quality software in hostile environments	https://chaos.guru/	954
GGPLOT2 101 – Getting started with data visualization	https://brunomioto.com/	955
Story Mapping Anti-Patterns	https://bitbytebit.substack.com/	956
How I'm funded	https://roe.dev/	957
All Revenue Is Not Created Equal: The Keys to the 10x Revenue Club	https://abovethecrowd.com/	958
Look, ma, no matrices	https://enkimute.github.io/	959
On Abandoning My RATGDO Native HomeKit Users	https://thenewwazoo.github.io/	960
Khanmigo Doesn't Love Kids	https://danmeyer.substack.com/	961
Why I use Firefox	https://xn--ime-zza.eu/	962
Let's Fly (2014)	https://craigmod.com/	963
So, what did Apple break in the EU?	https://blog.tomayac.com/	964
What's the deal with Ctrl-Left and Ctrl-right?	https://www.niladicpodcast.com/	965
Newtypes Aren't as Cool as You Think (2014)	https://degoes.net/	966
Speed Up Your Elixir Testing with Custom Tasks and Key Bindings in VSC	https://solnic.dev/	967
Azure's Browser Bias	https://matt-w.net/	968
Don't mock machine learning models in unit tests	https://eugeneyan.com/	970
The end of coding? Nvidia's CEO sparks controversy	https://www.azhark.com/	971
My Annual Tool Exploration Journey	https://tw93.fun/	972
Difference Between GetElementByID and QuerySelector	https://kiru.io/	973
Pandas' pipe method and the empty object design pattern	https://benrutter.github.io/	974
Blind, Alone, and Confused for 24 Hours Challenge (2020)	https://mattlakeman.org/	975
Scheduling Internals	https://tontinton.com/	976
My Simplicity Toolkit: Testing	https://jensrantil.github.io/	977
Hermetic, but at What Cost?	https://fzakaria.com/	978
Building unorthodox deep learning GPU machines	https://www.kyleboddy.com/	979
Why Books Don't Work	https://andymatuschak.org/	980
Turning Helix into an IDE with the Help of WezTerm and CLI Tools	https://quantonganh.com/	981
Language models can only write ransom notes	https://posts.decontextualize.com/	982
You Probably *Do* Need ESLint-Prettier	https://lukedeniston.com/	984
Indexed types for a statically safe WebAssembly [pdf]	https://williamjbowman.com/	985
How Not to Read Hegel	https://loveofallwisdom.com/	986
Pimsleur: The Duolingo of My Youth	https://hearsay.tech/	987
Serverless Horrors	https://serverlesshorrors.com/	988
LLM Quantisation Weirdness	https://www.gilesthomas.com/	989
Hell: Shell Scripting Haskell Dialect	https://chrisdone.com/	990
Definite Optimism as Human Capital	https://danwang.co/	991
Pursuing Agency and Reinvention in My 30s	https://pursuingagency.substack.com/	992
Earth Is Becoming Sentient	https://stephango.com/	993
SQL Reunion: People, Projects, and Politics (1997) [pdf]	https://www.mcjones.org/	994
Encoding tic-tac-toe in 13 bits	https://ashdnazg.github.io/	995
JSR First Impressions	https://kitsonkelly.com/	996
What is Rust's Unsafe? (2019)	https://nora.codes/	997
Transformative Work as Livelihood	https://gemmacope.land/	998
You can't be too happy	https://www.experimental-history.com/	999
I had a perfectly nice domain and then the Taliban ruined it	https://opinionated.af.yachts/	1000
All you need is Wide Events, not "Metrics, Logs and Traces"	https://isburmistrov.substack.com/	1001
The Chemistry of Refrigerants (2022)	https://www.moderndescartes.com/	1002
Diffusion Local Time, a timepiece made of generative AI art, at Art Hack Day	https://leebutterman.com/	1003
How-To Calibrate American Options Really Fast in C++	https://tastyhedge.com/	1004
We're using custom domain email for $0/mo	https://maxprilutskiy.com/	1005
Elbow Method and Finding the Right Number of Clusters (2015)	https://www.nbertagnolli.com/	1006
The Unbundling of Venture Capital	https://kwharrison13.com/	1007
Zero-downtime schema migrations in Postgres using views	https://fabianlindfors.se/	1008
The Implications of Copyrighting Golf Courses: H.R. 7228	https://golfcoursewiki.substack.com/	1009
Pure Programming Language	https://agraef.github.io/	1010
Best ZK onboarding blog post for developers	https://blog.borodutch.com/	1011
The Power of Lost Minutes	https://blog.jellesmeets.nl/	1012
The Future Needs Files	https://jenson.org/	1013
When surge pricing hits, your wallet takes a thrashing	https://ldstephens.me/	1014
You know computers, what should I buy?	https://bruegge.dev/	1015
The Structure of a Programming Language Revolution (2021) [pdf]	https://dreamsongs.com/	1016
More Files Please	https://blog.jim-nielsen.com/	1017
Frink	https://futureboy.us/	1018
Airfoil	https://ciechanow.ski/	1019
A new aspect of Google's spying	https://www.michaelhorowitz.com/	1020
Proposal for a Walkable City in California	https://devon.postach.io/	1021
Why can't we shoot down drones? It's a political, not a technical problem	https://bowoftheseus.substack.com/	1022
What if everybody did everything right? – Surfing Complexity	https://surfingcomplexity.blog/	1023
K-Means Clustering in Klong (2019)	https://idle.nprescott.com/	1024
\.


--
-- Name: tbllinks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbllinks_id_seq', 1024, true);


--
-- Name: tbllinks tbllinks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbllinks
    ADD CONSTRAINT tbllinks_pkey PRIMARY KEY (url, id);


--
-- PostgreSQL database dump complete
--

