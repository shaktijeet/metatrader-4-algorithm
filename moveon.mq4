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
extern int TakeProfit = 50;
extern int StopLoss = 25;
extern int FastMA=5;
extern int FastMaShift= 0;
 extern int FastMaMethod = 0;
 extern int FastMaAppliedTo = 0;;
extern int SlowMA=21;
extern int SlowMaShift= 0;
 extern int SlowMaMethod = 0;
 extern int SlowMaAppliedTo = 0;;
extern double LotSize = 0.01;
extern int MagicNumber = 2342;
double pips;


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

double PreviousFast = iMA(NULL,0,FastMA,FastMaShift,FastMaMethod, FastMaAppliedTo,2);

double CurrentFast = iMA(NULL,0,FastMA,FastMaShift,FastMaMethod, FastMaAppliedTo,1);



double PreviousSlow = iMA(NULL,0,SlowMA,SlowMaShift,SlowMaMethod, SlowMaAppliedTo,2);

double CurrentSlow =   iMA(NULL,0,SlowMA,SlowMaShift,SlowMaMethod, SlowMaAppliedTo,1);

if( PreviousFast<PreviousSlow && CurrentFast>CurrentSlow)
  if(OrdersTotal()==0){
    if(OrderSend(Symbol(),OP_BUY,LotSize,Ask,3,Ask-(StopLoss*pips),Ask+(TakeProfit*pips),NULL,MagicNumber,0,Green)==true)
    Print("Buying take place");
    
    }
if( PreviousFast>PreviousSlow && CurrentFast<CurrentSlow)
  if(OrdersTotal()==0){
    if (  OrderSend(Symbol(),OP_SELL,LotSize,Bid,3,Bid+(StopLoss*pips),Bid-(TakeProfit*pips),NULL,MagicNumber,0,Red)==true)
      Print("selling take place");
  }
  
  return (0);
}