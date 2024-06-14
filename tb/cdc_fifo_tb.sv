module cdc_fifo_tb;

  
  localparam int Elem_Width = 4;
  localparam int Fifo_Size = 2;

 
  bit arst_ni = 1;
  logic elem_in_clk_i = 0;
  bit [Elem_Width-1:0] elem_in_i;
  bit elem_in_valid_i = 0;
  bit elem_in_ready_o;
  logic elem_out_clk_i = 0;
  bit [Elem_Width-1:0] elem_out_o;
  bit elem_out_valid_o;
  bit elem_out_ready_i = 0;


  initial forever begin
	  #5 elem_in_clk_i = ~ elem_in_clk_i;
	  #5 elem_out_clk_i = ~ elem_out_clk_i;
  end


  cdc_fifo #(
      .ELEM_WIDTH(Elem_Width),
      .FIFO_SIZE (Fifo_Size)
  ) cdc_pipeline_dut (
      .arst_ni(arst_ni),
      .elem_in_clk_i(elem_in_clk_i),
      .elem_in_i(elem_in_i),
      .elem_in_valid_i(elem_in_valid_i),
      .elem_in_ready_o(elem_in_ready_o),
      .elem_out_clk_i(elem_out_clk_i),
      .elem_out_o(elem_out_o),
      .elem_out_valid_o(elem_out_valid_o),
      .elem_out_ready_i(elem_out_ready_i)
  );

  task static apply_reset();
    #100;
    arst_ni = 0;
    #100;
    arst_ni = 1;
    #100;
  endtask


  initial begin
    apply_reset();   
   
    fork
      forever begin
        @(posedge elem_in_clk_i);
        elem_in_i <= $urandom;
      end
    join_none

    fork
      begin
        @(posedge elem_in_clk_i);
        elem_in_valid_i <= '1;
      end
      begin
        @(posedge elem_out_clk_i);
        elem_out_ready_i <= '1;
      end
    join

    fork
      forever begin
         @(posedge elem_in_clk_i);
	 $display("Input Data = %d and Output Data = %d",elem_in_i,elem_out_o);
      end
      forever begin
        @(posedge elem_out_clk_i);
	$display("Input Data = %d and Output Data = %d",elem_in_i,elem_out_o);

      end
	#350;

     join_any

    $finish;

  end

endmodule


