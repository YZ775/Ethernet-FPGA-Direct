module top(
	input CLK,
	input RST,
	output reg [8:0] LEDR,
	output [1:0] ARDUINO_IO
);
	
	wire PLL_CLK;
	//TENBASET_TxD t (.clk20(PLL_CLK), .Ethernet_TDp(ARDUINO_IO[0]), .Ethernet_TDm(ARDUINO_IO[1]) );
	TEN_BT t (.PLL_CLK(PLL_CLK), .TX_P(ARDUINO_IO[0]), .TX_N(ARDUINO_IO[1]));
	
	pll p (.areset(0), .inclk0(CLK), .c0(PLL_CLK), .locked());

endmodule

	/*
	reg[0:575] data;
	reg [63:0] transmit_count;

	reg data_enable;
	wire TX_P;
	wire TX_N;
	
	
	assign ARDUINO_IO[0] = TX_P;
	assign ARDUINO_IO[1] = TX_N;
	
	always@(posedge PLL_CLK )begin
		if(RST == 1)begin
			LEDR[0] <=1;
			data[0:7] <= 8'b10101010; //preamble
			data[8:15] <= 8'b10101010;
			data[16:23] <= 8'b10101010;
			data[24:31] <= 8'b10101010;
			data[32:39] <= 8'b10101010;
			data[40:47] <= 8'b10101010;
			data[48:55] <= 8'b10101010;

			data[56:63] <= 8'b10101011; //start
			
			data[64:111]  <= 48'hffffffffffff; //source addr
			data[112:159] <= 48'h000000000000; //dst addr

			data[160:175] <=16'h002e; //type(46bytes)
			
			data[176:543] <= 0; //data

			data[544:575] <= 0; //CRC

			transmit_count <= 0;
			data_enable <= 1;
		end
		else begin
			LEDR[0] <=0;
			if(transmit_count > 575)begin
				data <= 0;
				data_enable <= 0;
			end
			else begin
				transmit_count <= transmit_count + 1;
			end
		end
	end


	pll p (.areset(0), .inclk0(CLK), .c0(PLL_CLK), .locked());
	decode d(.CLK(PLL_CLK), .RST(RST), .TX_P(TX_P), .TX_N(TX_N), .data(data), .data_enable(data_enable));

endmodule






module decode(
	input CLK,
	input RST,
	input data_enable,
	output reg TX_P,
	output reg TX_N,
	input [0:575] data
);

	
	reg [575:0] count;
	reg m_count;
	reg show_data;



	always @(posedge CLK)begin
	if(RST || data_enable == 0)begin
		TX_P <= 0;
		TX_N <= 0;
		count <= 0;
		m_count <= 0;
	end
	else begin
		show_data <= data[count/2];
		if(data[count/2] == 1)begin
			if(m_count == 0)begin
				TX_P <= 1;
				TX_N <= 0;
				m_count <= 1;
			end
			else begin
				TX_P <= 0;
				TX_N <= 1;
				m_count <= 0;
			end
		end
		
		else begin
			if(m_count == 0)begin
				TX_P <= 0;
				TX_N <= 1;
				m_count <= 1;
			end
			else begin
				TX_P <= 1;
				TX_N <= 0;
				m_count <= 0;
			end
		end
		count <= count + 1;
	end


	end


endmodule
*/