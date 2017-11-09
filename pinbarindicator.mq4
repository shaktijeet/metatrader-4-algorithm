//+------------------------------------------------------------------+
//|                                              pinbarindicator.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window
#property indicator_buffers 2  //two place in memory that for up down
#property indicator_color1 clrGreen  //first buffer
#property indicator_color2 clrRed    //second buffer
//--- input parameters
extern double   bmi=25.0;
//make an array to hold the no
double up[];
double down[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
  bmi*=0.1;
  
//--- indicator buffers mapping
   //what you want to map
   SetIndexBuffer(0,up);
   //you are going to decide for a no to put in this buffer
   SetIndexStyle(0,DRAW_ARROW);
   SetIndexArrow(0,233);
   SetIndexLabel(0,"Up Arrow");
   
   
   SetIndexBuffer(1,down);
   SetIndexStyle(1,DRAW_ARROW);
   SetIndexArrow(1,234);
   SetIndexLabel(1,"Down Arrow");
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
  // up[2]=High[2];// that show the slice position
   
  // down[1]=Low[1];
  
  //logic in pinbar indicator
  //make two variable one of them hold the total size of candle 
  double total = High[1]-Low[1];
  
  //for the red (open - close)
  double body = MathAbs(Open[1] -Close[1]);  // To remove the negative no to give tha postive no
  double maxSize=total*bmi;
  if(body<maxSize
  && Open[1]<Close[1]
  && High[1]-Open[1]<maxSize
  &&Low[1]<Low[2]
  &&Low[1]<Low[3])
  up[1] = Close[1];
  else if(body<maxSize
  &&Open[1]>Close[1]
  &&Open[1]-Low[1]<maxSize
  &&High[1]>High[2]
  &&High[1]>High[3])
  down[1] = Close[1];
  //return value of prev_calculated for 
  
  
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   
  }
//+------------------------------------------------------------------+
