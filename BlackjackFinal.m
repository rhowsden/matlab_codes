runs = 1000;
%Adding a comment for GitHub testing

function blackjack(runs)
%Number of runs needs > 1 million for accuracy
global sp so ha truecount count stats splits value betvalue moneyin moneyout
%Initialization
splits = 0;
count = 0;
stats = zeros(1,5);
moneyin = 0;
moneyout = 0;
collectcount = zeros(1,runs);

%Decision matrix for Splitting
sp=  [0     0     0     0     0     0     0     0     0     0     0;
      0     4     4     4     4     4     4     1     1     1     1;
      0     4     4     4     4     4     4     1     1     1     1;
      0     1     1     1     4     4     1     1     1     1     1;
      0     3     3     3     3     3     3     3     3     1     1;
      0     4     4     4     4     4     1     1     1     1     1;
      0     4     4     4     4     4     4     1     1     1     1;
      0     4     4     4     4     4     4     4     4     4     4;
      0     4     4     4     4     4     2     4     4     2     2;
      0     2     2     2     2     2     2     2     2     2     2;
      0     4     4     4     4     4     4     4     4     4     4];
%Decision matrix for Soft Hands
so= [0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0;
     0     1     1     1     1     3     1     1     1     1     1;
     0     1     1     1     3     3     1     1     1     1     1;
     0     1     1     3     3     3     1     1     1     1     1;
     0     1     1     3     3     3     1     1     1     1     1; 
     0     1     3     3     3     3     1     1     1     1     1;
     0     2     5     5     5     5     2     2     1     1     1;
     0     2     2     2     2     2     2     2     2     2     2;
     0     2     2     2     2     2     2     2     2     2     2;
     0     2     2     2     2     2     2     2     2     2     2];
 %Decision matrix for Hard Hands
 ha=[0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0;
     0     1     1     1     1     1     1     1     1     1     1;
     0     1     1     1     1     1     1     1     1     1     1;
     0     1     1     1     1     1     1     1     1     1     1;
     0     1     1     1     1     1     1     1     1     1     1;
     0     1     3     3     3     3     1     1     1     1     1;
     0     3     3     3     3     3     3     3     3     1     1;
     0     3     3     3     3     3     3     3     3     3     1;
     0     1     1     2     2     2     1     1     1     1     1;
     0     2     2     2     2     2     1     1     1     1     1;
     0     2     2     2     2     2     1     1     1     1     1;
     0     2     2     2     2     2     1     1     1     1     1;
     0     2     2     2     2     2     1     1     1     1     1;
     0     2     2     2     2     2     2     2     2     2     2;
     0     2     2     2     2     2     2     2     2     2     2;
     0     2     2     2     2     2     2     2     2     2     2;
     0     2     2     2     2     2     2     2     2     2     2;
     0     2     2     2     2     2     2     2     2     2     2];
 
value = [2,3,3,4,3,2,0,-1,-3,-4,-3,-3,-3];
%value = [1,1,2,2,1,1,0,0,-2,0,-2,-2,-2];
%value = [1,1,1,1,1,0,0,0,-1,-1,-1,-1,-1];
betvalue = [1,2,4,8,16,32,64];

percentage = zeros(1,10);

%Random walk

for k=1:1000
for i=1:runs
    collectcount(i)=truecount;
    dealhand
end
percentage(k) = moneyout/moneyin;

if k > 1
    if percentage(k-1) > percentage(k)
        value=oldvalue;
    end
end
moneyout = 0;
moneyin = 0;
var1=ceil(10*rand);
var2=ceil(10*rand);

while(var2 == var1)
    var2=ceil(10*rand);
end

oldvalue=value;
value(var1)=value(var1)+.25;
value(var2)=value(var2)-.25;
end
%Returns some statistics
value %Returns new count system
mean(percentage)
std(percentage)


 
function dealhand
%Places bet according to count and deals both hands
global stats bet truecount betvalue initbet moneyin moneyout

if truecount < 1
    bet = betvalue(1);
elseif truecount > 7
    bet = betvalue(7);
else
    bet = betvalue(floor(truecount));
end

initbet = bet;

P = [deal,deal];
D = [deal,deal];

%Analyzes early "win/lose" situations where dealer or player gets 21

if sum(P) == 21 && sum(D) == 21
    stats(2) = stats(2)+1;
    moneyin = moneyin + bet;
    moneyout = moneyout + bet;
elseif sum(P) == 21
    stats(4) = stats(4)+1;
    moneyin = moneyin + bet;
    moneyout = moneyout + bet*2.5;
elseif sum(D) == 21
    stats(5) = stats(5)+1;
    moneyin = moneyin + bet;
else
    decision(P,D)
end

function decision(P,D)
%Calls element of matrix to make decision to hit,stand,split or double
global sp so ha

if P(1) == P(2)
    dec = sp(P(1),D(1));
elseif any(P==11)
    dec = so(sum(P),D(1));
else
    dec = ha(sum(P),D(1));
end

if dec == 1
    hit(P,D)
elseif dec == 2
    dealerplay(P,D)
elseif dec == 3 || dec == 5
    double(P,D)
elseif dec == 4
    split(P,D)
end
 
function card = deal
global truecount count value deck
% Deal one card
if length(deck) < 52
   % Six decks
   deck = ceil([5:56 5:56 5:56 5:56 5:56 5:56]/4);
   % Shuffle
   deck = deck(randperm(length(deck)));
   count = 0;
end
draw = deck(end);
%Keeps track of count
count = count + value(draw-1);
if draw >= 12
    card = 10;
else
    card = draw;
end
truecount = count/(length(deck)/52);
deck(end) = [];

function hit(P,D)
%Function for hitting in Blackjack
global so ha stats bet moneyin
dec = 0;
P(end+1) = deal;
if sum(P) > 21
    if any(P==11)
        if sum(P)-10 < 22
            dec = ha(sum(P)-10,D(1));
        else
            stats(3) = stats(3) + 1;
            moneyin = moneyin + bet;
        end
    else
        stats(3) = stats(3) + 1;
        moneyin = moneyin + bet;
    end
else
    if any(P==11)
        dec = so(sum(P),D(1));
    else
        dec = ha(sum(P),D(1));
    end
end

if dec == 1 || dec == 3
    hit(P,D)
elseif dec == 2 || dec == 5
    dealerplay(P,D)
end

function double(P,D)
%Function for doubling
global bet
P(end+1) = deal;
bet = 2*bet;
dealerplay(P,D)


function split(P,D)
%Function for splitting
global splits bet initbet

splits = splits + 1;
i = 1;
NofHands = 2;
while (i <= NofHands)
P(i,:) = [P(1),deal];
    if P(i,1) == P(i,2)
        NofHands = NofHands + 1;
        P(i,2) = deal;
        splits = splits + 1;
    end
i = i+1;
end

for j=1:NofHands
    bet = initbet;
    decision(P(j,:),D)
end

function dealerplay(P,D)
%Function for standing, dealer begins play
global stats bet moneyin moneyout

while sum(D) < 17    
    D(end+1) = deal;
    if any(D==11)
        if sum(D) > 21
            if any(D==-10)
            else
                D(end+1) = -10;
            end
        end
    end
end

if sum(P) > 21
    C = sum(P)-10;
else
    C = sum(P);
end

if sum(D) > 21
    stats(1) = stats(1) + 1;
    moneyin = moneyin + bet;
    moneyout = moneyout + 2*bet;
elseif C > sum(D)
    stats(1) = stats(1) + 1;
    moneyin = moneyin + bet;
    moneyout = moneyout + 2*bet;
elseif C == sum(D)
    stats(2) = stats(2) + 1;
    moneyin = moneyin + bet;
    moneyout = moneyout + bet;
elseif C < sum(D)
    stats(3) = stats(3) + 1;
    moneyin = moneyin + bet;
end

    

