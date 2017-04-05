//------------------------------------------------------------------------------
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version : 3.6
//  \   \         Application : 7 Series FPGAs Transceivers Wizard 
//  /   /         Filename : evrgtx_init.v
// /___/   /\      
// \   \  /  \ 
//  \___\/\___\
//
//  Description : This module instantiates the modules required for
//                reset and initialisation of the Transceiver
//
// Module evrGTX_init
// Generated by Xilinx 7 Series FPGAs Transceivers Wizard
// 
// 
// (c) Copyright 2010-2012 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES. 


`timescale 1ns / 1ps
`define DLY #1

//***********************************Entity Declaration************************
(* DowngradeIPIdentifiedWarnings="yes" *)
module evrGTX_init #
(
    parameter EXAMPLE_SIM_GTRESET_SPEEDUP            = "TRUE",     // Simulation setting for GT SecureIP model
    parameter EXAMPLE_SIMULATION                     =  0,         // Set to 1 for simulation
    parameter USE_BUFG                               =  0,         // Set to 1 for BUFG usage in cpll railing logic
    parameter STABLE_CLOCK_PERIOD                    = 10,         //Period of the stable clock driving this state-machine, unit is [ns]
    parameter EXAMPLE_USE_CHIPSCOPE                  =  0          // Set to 1 to use Chipscope to drive resets

)
(
input           sysclk_in,
input           soft_reset_rx_in,
input           dont_reset_on_data_error_in,
output          gt0_tx_fsm_reset_done_out,
output          gt0_rx_fsm_reset_done_out,
input           gt0_data_valid_in,

    //_________________________________________________________________________
    //GT0  (X1Y10)
    //____________________________CHANNEL PORTS________________________________
    //------------------------------- CPLL Ports -------------------------------
    output          gt0_cpllfbclklost_out,
    output          gt0_cplllock_out,
    input           gt0_cplllockdetclk_in,
    input           gt0_cpllreset_in,
    //------------------------ Channel - Clocking Ports ------------------------
    input           gt0_gtrefclk0_in,
    input           gt0_gtrefclk1_in,
    //-------------------------- Channel - DRP Ports  --------------------------
    input   [8:0]   gt0_drpaddr_in,
    input           gt0_drpclk_in,
    input   [15:0]  gt0_drpdi_in,
    output  [15:0]  gt0_drpdo_out,
    input           gt0_drpen_in,
    output          gt0_drprdy_out,
    input           gt0_drpwe_in,
    //------------------------- Digital Monitor Ports --------------------------
    output  [7:0]   gt0_dmonitorout_out,
    //------------------- RX Initialization and Reset Ports --------------------
    input           gt0_eyescanreset_in,
    input           gt0_rxuserrdy_in,
    //------------------------ RX Margin Analysis Ports ------------------------
    output          gt0_eyescandataerror_out,
    input           gt0_eyescantrigger_in,
    //---------------- Receive Ports - FPGA RX Interface Ports -----------------
    input           gt0_rxusrclk_in,
    input           gt0_rxusrclk2_in,
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    output  [15:0]  gt0_rxdata_out,
    //---------------- Receive Ports - RX 8B/10B Decoder Ports -----------------
    output  [1:0]   gt0_rxdisperr_out,
    output  [1:0]   gt0_rxnotintable_out,
    //------------------------- Receive Ports - RX AFE -------------------------
    input           gt0_gtxrxp_in,
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    input           gt0_gtxrxn_in,
    //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
    output  [4:0]   gt0_rxphmonitor_out,
    output  [4:0]   gt0_rxphslipmonitor_out,
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    input           gt0_rxdfelpmreset_in,
    output  [6:0]   gt0_rxmonitorout_out,
    input   [1:0]   gt0_rxmonitorsel_in,
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    output          gt0_rxoutclk_out,
    output          gt0_rxoutclkfabric_out,
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    input           gt0_gtrxreset_in,
    input           gt0_rxpmareset_in,
    //----------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    output  [1:0]   gt0_rxcharisk_out,
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    output          gt0_rxresetdone_out,
    //------------------- TX Initialization and Reset Ports --------------------
    input           gt0_gttxreset_in,


    //____________________________COMMON PORTS________________________________
    input      gt0_qplloutclk_in,
    input      gt0_qplloutrefclk_in

);



//***********************************Parameter Declarations********************


    //Typical CDRLOCK Time is 50,000UI, as per DS183
    localparam RX_CDRLOCK_TIME      = (EXAMPLE_SIMULATION == 1) ? 1000 : 100000/1.625;
       
    integer   WAIT_TIME_CDRLOCK    = RX_CDRLOCK_TIME / STABLE_CLOCK_PERIOD;      

//-------------------------- GT Wrapper Wires ------------------------------
    wire           gt0_rxpmaresetdone_i;
    wire           gt0_txpmaresetdone_i;
    wire           gt0_cpllreset_i;
    wire           gt0_cpllreset_t;
    wire           gt0_cpllrefclklost_i;
    wire           gt0_cplllock_i;
    wire           gt0_txresetdone_i;
    wire           gt0_rxresetdone_i;
    wire           gt0_gttxreset_i;
    wire           gt0_gttxreset_t;
    wire           gt0_gtrxreset_i;
    wire           gt0_gtrxreset_t;
    wire           gt0_rxdfelpmreset_i;
    wire           gt0_txuserrdy_i;
    wire           gt0_txuserrdy_t;
    wire           gt0_rxuserrdy_i;
    wire           gt0_rxuserrdy_t;

    wire           gt0_rxdfeagchold_i;
    wire           gt0_rxdfelfhold_i;
    wire           gt0_rxlpmlfhold_i;
    wire           gt0_rxlpmhfhold_i;



    wire           gt0_qpllreset_i;
    wire           gt0_qpllreset_t;
    wire           gt0_qpllrefclklost_i;
    wire           gt0_qplllock_i;


//------------------------------- Global Signals -----------------------------
    wire          tied_to_ground_i;
    wire          tied_to_vcc_i;

    wire           gt0_txoutclk_i;
    wire           gt0_rxoutclk_i;
    wire           gt0_rxoutclk_i2;
    wire           gt0_txoutclk_i2;
    wire           gt0_recclk_stable_i;
    reg            gt0_rx_cdrlocked;
    integer  gt0_rx_cdrlock_counter= 0;
    wire           gt0_rxphaligndone_i;
    wire           gt0_rxdlysreset_i;
    wire           gt0_rxdlysresetdone_i;
    wire           gt0_rxphdlyreset_i;
    wire           gt0_rxphalignen_i;
    wire           gt0_rxdlyen_i;
    wire           gt0_rxphalign_i;
    wire           gt0_run_rx_phalignment_i;
    wire           gt0_rst_rx_phalignment_i;
    wire           gt0_rx_phalignment_done_i;




//    --------------------------- RX Buffer Bypass Signals --------------------
    wire   rxmstr0_rxsyncallin_i;
    wire  [0 : 0]        U0_RXDLYEN;
    wire  [0 : 0]        U0_RXDLYSRESET;
    wire  [0 : 0]        U0_RXDLYSRESETDONE;
    wire  [0 : 0]        U0_RXPHALIGN;
    wire  [0 : 0]        U0_RXPHALIGNDONE ;
    wire                                 U0_run_rx_phalignment_i;
    wire                                 U0_rst_rx_phalignment_i;




reg              rx_cdrlocked;


 


//**************************** Main Body of Code *******************************
    //  Static signal Assigments
assign  tied_to_ground_i                     =  1'b0;
assign  tied_to_vcc_i                        =  1'b1;

//    ----------------------------- The GT Wrapper -----------------------------
    
    // Use the instantiation template in the example directory to add the GT wrapper to your design.
    // In this example, the wrapper is wired up for basic operation with a frame generator and frame 
    // checker. The GTs will reset, then attempt to align and transmit data. If channel bonding is 
    // enabled, bonding should occur after alignment.


    evrGTX_multi_gt #
    (
        .USE_BUFG                       (USE_BUFG),
        .WRAPPER_SIM_GTRESET_SPEEDUP    (EXAMPLE_SIM_GTRESET_SPEEDUP)
    )
    evrGTX_i
    (
 
        //_____________________________________________________________________
        //_____________________________________________________________________
        //GT0  (X1Y10)

        //------------------------------- CPLL Ports -------------------------------
        .gt0_cpllfbclklost_out          (gt0_cpllfbclklost_out), // output wire gt0_cpllfbclklost_out
        .gt0_cplllock_out               (gt0_cplllock_i), // output wire gt0_cplllock_i
        .gt0_cplllockdetclk_in          (gt0_cplllockdetclk_in), // input wire gt0_cplllockdetclk_in
        .gt0_cpllrefclklost_out         (gt0_cpllrefclklost_i), // output wire gt0_cpllrefclklost_i
        .gt0_cpllreset_in               (gt0_cpllreset_i), // input wire gt0_cpllreset_i
        //------------------------ Channel - Clocking Ports ------------------------
        .gt0_gtrefclk0_in               (gt0_gtrefclk0_in), // input wire gt0_gtrefclk0_in
        .gt0_gtrefclk1_in               (gt0_gtrefclk1_in), // input wire gt0_gtrefclk1_in
        //-------------------------- Channel - DRP Ports  --------------------------
        .gt0_drpaddr_in                 (gt0_drpaddr_in), // input wire [8:0] gt0_drpaddr_in
        .gt0_drpclk_in                  (gt0_drpclk_in), // input wire gt0_drpclk_in
        .gt0_drpdi_in                   (gt0_drpdi_in), // input wire [15:0] gt0_drpdi_in
        .gt0_drpdo_out                  (gt0_drpdo_out), // output wire [15:0] gt0_drpdo_out
        .gt0_drpen_in                   (gt0_drpen_in), // input wire gt0_drpen_in
        .gt0_drprdy_out                 (gt0_drprdy_out), // output wire gt0_drprdy_out
        .gt0_drpwe_in                   (gt0_drpwe_in), // input wire gt0_drpwe_in
        //------------------------- Digital Monitor Ports --------------------------
        .gt0_dmonitorout_out            (gt0_dmonitorout_out), // output wire [7:0] gt0_dmonitorout_out
        //------------------- RX Initialization and Reset Ports --------------------
        .gt0_eyescanreset_in            (gt0_eyescanreset_in), // input wire gt0_eyescanreset_in
        .gt0_rxuserrdy_in               (gt0_rxuserrdy_i), // input wire gt0_rxuserrdy_i
        //------------------------ RX Margin Analysis Ports ------------------------
        .gt0_eyescandataerror_out       (gt0_eyescandataerror_out), // output wire gt0_eyescandataerror_out
        .gt0_eyescantrigger_in          (gt0_eyescantrigger_in), // input wire gt0_eyescantrigger_in
        //---------------- Receive Ports - FPGA RX Interface Ports -----------------
        .gt0_rxusrclk_in                (gt0_rxusrclk_in), // input wire gt0_rxusrclk_in
        .gt0_rxusrclk2_in               (gt0_rxusrclk2_in), // input wire gt0_rxusrclk2_in
        //---------------- Receive Ports - FPGA RX interface Ports -----------------
        .gt0_rxdata_out                 (gt0_rxdata_out), // output wire [15:0] gt0_rxdata_out
        //---------------- Receive Ports - RX 8B/10B Decoder Ports -----------------
        .gt0_rxdisperr_out              (gt0_rxdisperr_out), // output wire [1:0] gt0_rxdisperr_out
        .gt0_rxnotintable_out           (gt0_rxnotintable_out), // output wire [1:0] gt0_rxnotintable_out
        //------------------------- Receive Ports - RX AFE -------------------------
        .gt0_gtxrxp_in                  (gt0_gtxrxp_in), // input wire gt0_gtxrxp_in
        //---------------------- Receive Ports - RX AFE Ports ----------------------
        .gt0_gtxrxn_in                  (gt0_gtxrxn_in), // input wire gt0_gtxrxn_in
        //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
        .gt0_rxdlyen_in                 (gt0_rxdlyen_i), // input wire gt0_rxdlyen_i
        .gt0_rxdlysreset_in             (gt0_rxdlysreset_i), // input wire gt0_rxdlysreset_i
        .gt0_rxdlysresetdone_out        (gt0_rxdlysresetdone_i), // output wire gt0_rxdlysresetdone_i
        .gt0_rxphalign_in               (gt0_rxphalign_i), // input wire gt0_rxphalign_i
        .gt0_rxphaligndone_out          (gt0_rxphaligndone_i), // output wire gt0_rxphaligndone_i
        .gt0_rxphalignen_in             (gt0_rxphalignen_i), // input wire gt0_rxphalignen_i
        .gt0_rxphdlyreset_in            (gt0_rxphdlyreset_i), // input wire gt0_rxphdlyreset_i
        .gt0_rxphmonitor_out            (gt0_rxphmonitor_out), // output wire [4:0] gt0_rxphmonitor_out
        .gt0_rxphslipmonitor_out        (gt0_rxphslipmonitor_out), // output wire [4:0] gt0_rxphslipmonitor_out
        //------------------ Receive Ports - RX Equailizer Ports -------------------
        .gt0_rxlpmhfhold_in             (gt0_rxlpmhfhold_i), // input wire gt0_rxlpmhfhold_i
        .gt0_rxlpmlfhold_in             (gt0_rxlpmlfhold_i), // input wire gt0_rxlpmlfhold_i
        //------------------- Receive Ports - RX Equalizer Ports -------------------
        .gt0_rxdfelpmreset_in           (gt0_rxdfelpmreset_in), // input wire gt0_rxdfelpmreset_in
        .gt0_rxmonitorout_out           (gt0_rxmonitorout_out), // output wire [6:0] gt0_rxmonitorout_out
        .gt0_rxmonitorsel_in            (gt0_rxmonitorsel_in), // input wire [1:0] gt0_rxmonitorsel_in
        //------------- Receive Ports - RX Fabric Output Control Ports -------------
        .gt0_rxoutclk_out               (gt0_rxoutclk_i), // output wire gt0_rxoutclk_i
        .gt0_rxoutclkfabric_out         (gt0_rxoutclkfabric_out), // output wire gt0_rxoutclkfabric_out
        //----------- Receive Ports - RX Initialization and Reset Ports ------------
        .gt0_gtrxreset_in               (gt0_gtrxreset_i), // input wire gt0_gtrxreset_i
        .gt0_rxpmareset_in              (gt0_rxpmareset_in), // input wire gt0_rxpmareset_in
        //----------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        .gt0_rxcharisk_out              (gt0_rxcharisk_out), // output wire [1:0] gt0_rxcharisk_out
        //------------ Receive Ports -RX Initialization and Reset Ports ------------
        .gt0_rxresetdone_out            (gt0_rxresetdone_i), // output wire gt0_rxresetdone_i
        //------------------- TX Initialization and Reset Ports --------------------
        .gt0_gttxreset_in               (gt0_gttxreset_i), // input wire gt0_gttxreset_i




    //____________________________COMMON PORTS________________________________
        .gt0_qplloutclk_in              (gt0_qplloutclk_in),
        .gt0_qplloutrefclk_in           (gt0_qplloutrefclk_in)

    );


    assign  gt0_rxdfelpmreset_i                  =  tied_to_ground_i;


assign  gt0_cplllock_out                     =  gt0_cplllock_i;
assign  gt0_rxresetdone_out                  =  gt0_rxresetdone_i;
assign  gt0_rxoutclk_out                     =  gt0_rxoutclk_i;

generate
if (EXAMPLE_USE_CHIPSCOPE == 1) 
begin : chipscope
assign  gt0_cpllreset_i                      =  gt0_cpllreset_in || gt0_cpllreset_t;
assign  gt0_gttxreset_i                      =  gt0_gttxreset_in || gt0_gttxreset_t;
assign  gt0_gtrxreset_i                      =  gt0_gtrxreset_in || gt0_gtrxreset_t;
assign  gt0_rxuserrdy_i                      =  gt0_rxuserrdy_in || gt0_rxuserrdy_t;
end
endgenerate 

generate
if (EXAMPLE_USE_CHIPSCOPE == 0) 
begin : no_chipscope
assign  gt0_cpllreset_i                      =  gt0_cpllreset_t;
assign  gt0_gttxreset_i                      =  gt0_gttxreset_t;
assign  gt0_gtrxreset_i                      =  gt0_gtrxreset_t;
assign  gt0_txuserrdy_i                      =  gt0_txuserrdy_t;
assign  gt0_rxuserrdy_i                      =  gt0_rxuserrdy_t;
end
endgenerate 

assign gt0_txuserrdy_t = tied_to_ground_i;
assign gt0_gttxreset_t = tied_to_vcc_i;




evrGTX_RX_STARTUP_FSM  #
          (
           .EXAMPLE_SIMULATION       (EXAMPLE_SIMULATION),
           .EQ_MODE                  ("LPM"),                   //Rx Equalization Mode - Set to DFE or LPM
           .STABLE_CLOCK_PERIOD      (STABLE_CLOCK_PERIOD),              //Period of the stable clock driving this state-machine, unit is [ns]
           .RETRY_COUNTER_BITWIDTH   (8), 
           .TX_QPLL_USED             ("FALSE"),                          // the TX and RX Reset FSMs must
           .RX_QPLL_USED             ("FALSE"),                          // share these two generic values
           .PHASE_ALIGNMENT_MANUAL   ("FALSE")                 // Decision if a manual phase-alignment is necessary or the automatic 
                                                                         // is enough. For single-lane applications the automatic alignment is 
                                                                         // sufficient              
             )     
gt0_rxresetfsm_i
             ( 
        .STABLE_CLOCK                   (sysclk_in),
        .RXUSERCLK                      (gt0_rxusrclk_in),
        .SOFT_RESET                     (soft_reset_rx_in),
        .DONT_RESET_ON_DATA_ERROR       (dont_reset_on_data_error_in),
        .QPLLREFCLKLOST                 (tied_to_ground_i),
        .CPLLREFCLKLOST                 (gt0_cpllrefclklost_i),
        .QPLLLOCK                       (tied_to_vcc_i),
        .CPLLLOCK                       (gt0_cplllock_i),
        .RXRESETDONE                    (gt0_rxresetdone_i),
        .MMCM_LOCK                      (tied_to_vcc_i),
        .RECCLK_STABLE                  (gt0_recclk_stable_i),
        .RECCLK_MONITOR_RESTART         (tied_to_ground_i),
        .DATA_VALID                     (gt0_data_valid_in),
        .TXUSERRDY                      (tied_to_vcc_i),
        .GTRXRESET                      (gt0_gtrxreset_t),
        .MMCM_RESET                     (),
        .QPLL_RESET                     (),
        .CPLL_RESET                     (gt0_cpllreset_t),
        .RX_FSM_RESET_DONE              (gt0_rx_fsm_reset_done_out),
        .RXUSERRDY                      (gt0_rxuserrdy_t),
        .RUN_PHALIGNMENT                (gt0_run_rx_phalignment_i),
        .RESET_PHALIGNMENT              (gt0_rst_rx_phalignment_i),
        .PHALIGNMENT_DONE               (gt0_rx_phalignment_done_i),
        .RXDFEAGCHOLD                   (gt0_rxdfeagchold_i),
        .RXDFELFHOLD                    (gt0_rxdfelfhold_i),
        .RXLPMLFHOLD                    (gt0_rxlpmlfhold_i),
        .RXLPMHFHOLD                    (gt0_rxlpmhfhold_i),
        .RETRY_COUNTER                  ()
           );

  always @(posedge sysclk_in)
  begin
        if(gt0_gtrxreset_i)
        begin
          gt0_rx_cdrlocked       <= `DLY    1'b0;
          gt0_rx_cdrlock_counter <= `DLY    0;      
        end                
        else if (gt0_rx_cdrlock_counter == WAIT_TIME_CDRLOCK) 
        begin
          gt0_rx_cdrlocked       <= `DLY    1'b1;
          gt0_rx_cdrlock_counter <= `DLY    gt0_rx_cdrlock_counter;
        end
        else
          gt0_rx_cdrlock_counter <= `DLY    gt0_rx_cdrlock_counter + 1;
  end 

assign  gt0_recclk_stable_i                  =  gt0_rx_cdrlocked;






//   --------------------------- RX Buffer Bypass Logic --------------------
//   The RX SYNC Module drives the ports needed to Bypass the RX Buffer.
//   Include the RX SYNC module in your own design if RX Buffer is bypassed.


//Auto


assign  gt0_rxphdlyreset_i                   =  tied_to_ground_i;
assign  gt0_rxphalignen_i                    =  tied_to_ground_i;
assign  gt0_rxdlyen_i                        =  tied_to_ground_i;
assign  gt0_rxphalign_i                      =  tied_to_ground_i;


evrGTX_AUTO_PHASE_ALIGN 
gt0_rx_auto_phase_align_i 
     ( 
        .STABLE_CLOCK                   (sysclk_in),
        .RUN_PHALIGNMENT                (gt0_run_rx_phalignment_i),
        .PHASE_ALIGNMENT_DONE           (gt0_rx_phalignment_done_i),
        .PHALIGNDONE                    (gt0_rxphaligndone_i),
        .DLYSRESET                      (gt0_rxdlysreset_i),
        .DLYSRESETDONE                  (gt0_rxdlysresetdone_i),
        .RECCLKSTABLE                   (gt0_recclk_stable_i)
     );



endmodule

