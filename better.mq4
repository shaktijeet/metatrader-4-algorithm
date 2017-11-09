//+------------------------------------------------------------------+
//|                                                       moveon.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
extern int TakeProfit = 35;
extern int StopLoss = 25;


extern bool UseMoveToBreakeven= true;
extern int WhenToMoveBe = 100;
extern int PipsToLockIn = 5;

extern int FastMA=7;
extern int FastMaShift= 0;
 extern int FastMaMethod = 1;
 extern int FastMaAppliedTo = 2;
extern int SlowMA=20;
extern int SlowMaShift= 0;
 extern int SlowMaMethod = 1;
 extern int SlowMaAppliedTo = 2;
extern double LotSize = 0.01;
extern int MagicNumber = 1234;
double pips;
double awesome;


int init()
 {

     double ticksize = MarketInfo(Symbol(), MODE_TICKSIZE);
     if(ticksize == 0.00001 || ticksize == 0.001)
     pips = ticksize*10;
     else pips = ticksize;
  
  return (0);
  }
int deinit()
{


return (0);
}

int start()
{

  if(IsNewCandle())CheckForTrade();
  
  
  return (0);
}


 bool IsNewCandle()
 {
 static  int  BarsOnChart=1234;
   if(Bars == BarsOnChart)
 
 //in the array 
    
    return (false);
    
    BarsOnChart = Bars;
   
 return (true);
 
 
 }
void CheckForTrade()
{
double PreviousFast = iMA(NULL,0,FastMA,FastMaShift,FastMaMethod, FastMaAppliedTo,2);

double CurrentFast = iMA(NULL,0,FastMA,FastMaShift,FastMaMethod, FastMaAppliedTo,1);



double PreviousSlow = iMA(NULL,0,SlowMA,SlowMaShift,SlowMaMethod, SlowMaAppliedTo,2);

double CurrentSlow =     iMA(NULL,0,SlowMA,SlowMaShift,SlowMaMethod, SlowMaAppliedTo,1);

//Awesome oscillator indicator coding start




if( PreviousFast<PreviousSlow && CurrentFast>CurrentSlow)

awesome = iAO(NULL , 0,1);
if(awesome ==0|| awesome >0)

OrderEntry(0);

if( PreviousFast>PreviousSlow && CurrentFast<CurrentSlow)
awesome = iAO(NULL , 0,1);
if(awesome ==0|| awesome <0)
OrderEntry(1);

}



void OrderEntry(int direction)
{

if(direction == 0)
     if(OrdersTotal()==0)
     if(OrderSend(Symbol(),OP_BUY,LotSize,Ask,3,Ask-(StopLoss*pips),Ask+(TakeProfit*pips),NULL,MagicNumber,0,Green)==true)
      
     
     Print("Buying take place");

if(direction==1)
  if(OrdersTotal()==0) 
 
 double  current_ao = iAO(NULL, 0, 1);
  if(OrderSend(Symbol(),OP_SELL,LotSize,Bid,3,Bid+(StopLoss*pips),Bid-(TakeProfit*pips),NULL,MagicNumber,0,Red)==true)
 
  
  
  Print("Selling Take place");
}  

/*

void awesome_oscillator(){

double  current_ao = iAO(NULL, 0, 1);
double previous_ao = iAO(NULL, 0, 2);

//now make condition to changing the color of green in red and red in  green 
if(previous_ao<0 && current_ao > 0){

///order send mobule take here
}



}
*/