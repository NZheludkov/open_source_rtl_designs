
/*
	Copyright 2023 Efabless Corp.

	Author: Mohamed Shalan (mshalan@efabless.com)

	This file is auto-generated by wrapper_gen.py on 2023-11-06

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	    http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

*/


`timescale			1ns/1ns
`default_nettype	none

`define		WB_BLOCK(name, init)	always @(posedge clk_i or posedge rst_i) if(rst_i) name <= init;
`define		WB_REG(name, init)		`WB_BLOCK(name, init) else if(wb_we & (adr_i==``name``_ADDR)) name <= dat_i;
`define		WB_ICR(sz)				`WB_BLOCK(ICR_REG, sz'b0) else if(wb_we & (adr_i==ICR_REG_ADDR)) ICR_REG <= dat_i; else ICR_REG <= sz'd0;

module EF_I2S_wb (
	output	wire 		ws,
	output	wire 		sck,
	input	wire 		sdi,
	output	wire 		sdo,
	input	wire 		clk_i,
	input	wire 		rst_i,
	input	wire [31:0]	adr_i,
	input	wire [31:0]	dat_i,
	output	wire [31:0]	dat_o,
	input	wire [3:0]	sel_i,
	input	wire 		cyc_i,
	input	wire 		stb_i,
	output	reg 		ack_o,
	input	wire 		we_i,
	output	wire 		irq
);
	localparam[15:0] RXDATA_REG_ADDR = 16'h0000;
	localparam[15:0] PRESCALE_REG_ADDR = 16'h0004;
	localparam[15:0] FIFOLEVEL_REG_ADDR = 16'h0008;
	localparam[15:0] RXFIFOT_REG_ADDR = 16'h000c;
	localparam[15:0] CONTROL_REG_ADDR = 16'h0010;
	localparam[15:0] CONFIG_REG_ADDR = 16'h0014;
	localparam[15:0] ICR_REG_ADDR = 16'h0f00;
	localparam[15:0] RIS_REG_ADDR = 16'h0f04;
	localparam[15:0] IM_REG_ADDR = 16'h0f08;
	localparam[15:0] MIS_REG_ADDR = 16'h0f0c;
	localparam[15:0] CG_REG_ADDR = 16'h0f80;

	reg	[7:0]	PRESCALE_REG;
	reg	[4:0]	RXFIFOT_REG;
	reg	[0:0]	CONTROL_REG;
	reg	[4:0]	CONFIG_REG;
	reg	[2:0]	RIS_REG;
	reg	[2:0]	ICR_REG;
	reg	[2:0]	IM_REG;
	reg	[0:0]	CG_REG;

	wire[31:0]	fifo_rdata;
	wire[31:0]	RXDATA_REG	= fifo_rdata;
	wire[7:0]	sck_prescaler	= PRESCALE_REG[7:0];
	wire[4:0]	fifo_level;
	wire[4:0]	FIFOLEVEL_REG	= fifo_level;
	wire[4:0]	fifo_level_threshold	= RXFIFOT_REG[4:0];
	wire		en	= CONTROL_REG[0:0];
	wire[1:0]	channels	= CONFIG_REG[1:0];
	wire		sign_extend	= CONFIG_REG[2:2];
	wire		left_justified	= CONFIG_REG[3:3];
	wire[4:0]	sample_size	= CONFIG_REG[8:4];
	wire		fifo_empty;
	wire		_EMPTY_FLAG_FLAG_	= fifo_empty;
	wire		fifo_level_above;
	wire		_ABOVE_FLAG_FLAG_	= fifo_level_above;
	wire		fifo_full;
	wire		_FULL_FLAG_FLAG_	= fifo_full;
	wire[2:0]	MIS_REG	= RIS_REG & IM_REG;
	wire		wb_valid	= cyc_i & stb_i;
	wire		wb_we	= we_i & wb_valid;
	wire		wb_re	= ~we_i & wb_valid;
	wire[3:0]	wb_byte_sel	= sel_i & {4{wb_we}};
	wire		_clk_	= clk_i;
	wire		_gclk_;
	wire		_rst_	= rst_i;
	wire		rd	= (wb_re & (adr_i==RXDATA_REG_ADDR)  & ack_o);

	assign _gclk_ = _clk_;

	EF_I2S inst_to_wrap (
		.clk(_gclk_),
		.rst_n(~_rst_),
		.ws(ws),
		.sck(sck),
		.sdi(sdi),
		.sdo(sdo),
		.fifo_rd(fifo_rd),
		.fifo_level_threshold(fifo_level_threshold),
		.fifo_full(fifo_full),
		.fifo_empty(fifo_empty),
		.fifo_level(fifo_level),
		.fifo_level_above(fifo_level_above),
		.fifo_rdata(fifo_rdata),
		.sign_extend(sign_extend),
		.left_justified(left_justified),
		.sample_size(sample_size),
		.sck_prescaler(sck_prescaler),
		.channels(channels),
		.en(en)
	);

	always @ (posedge clk_i or posedge rst_i)
		if(rst_i) ack_o <= 1'b0;
		else
			if(wb_valid & ~ack_o)
				ack_o <= 1'b1;
			else
				ack_o <= 1'b0;

	`WB_REG(PRESCALE_REG, 0)
	`WB_REG(RXFIFOT_REG, 0)
	`WB_REG(CONTROL_REG, 0)
	`WB_REG(CONFIG_REG, 0)
	`WB_REG(IM_REG, 0)
	`WB_REG(CG_REG, 0)

	`WB_ICR(3)

	always @ (posedge clk_i or posedge rst_i)
		if(rst_i) RIS_REG <= 32'd0;
		else begin
			if(_EMPTY_FLAG_FLAG_) RIS_REG[0] <= 1'b1; else if(ICR_REG[0]) RIS_REG[0] <= 1'b0;
			if(_ABOVE_FLAG_FLAG_) RIS_REG[1] <= 1'b1; else if(ICR_REG[1]) RIS_REG[1] <= 1'b0;
			if(_FULL_FLAG_FLAG_) RIS_REG[2] <= 1'b1; else if(ICR_REG[2]) RIS_REG[2] <= 1'b0;

		end

	assign irq = |MIS_REG;

	assign	dat_o = 
			(adr_i == PRESCALE_REG_ADDR) ? PRESCALE_REG :
			(adr_i == RXFIFOT_REG_ADDR) ? RXFIFOT_REG :
			(adr_i == CONTROL_REG_ADDR) ? CONTROL_REG :
			(adr_i == CONFIG_REG_ADDR) ? CONFIG_REG :
			(adr_i == RIS_REG_ADDR) ? RIS_REG :
			(adr_i == ICR_REG_ADDR) ? ICR_REG :
			(adr_i == IM_REG_ADDR) ? IM_REG :
			(adr_i == CG_REG_ADDR) ? CG_REG :
			(adr_i == RXDATA_REG_ADDR) ? RXDATA_REG :
			(adr_i == FIFOLEVEL_REG_ADDR) ? FIFOLEVEL_REG :
			(adr_i == MIS_REG_ADDR) ? MIS_REG :
			32'hDEADBEEF;

endmodule