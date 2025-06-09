
module tb_top;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  `include "trans.sv"
  `include "tlm_pro.sv"
  `include "tlm_con.sv"

  class top extends uvm_component;
    `uvm_component_utils(top)

    producer p_h;
    consumer c_h;

    //uvm_blocking_put_port   #(trans) put_port;
    //uvm_blocking_put_export #(trans) put_exp;

    function new(string name="top", uvm_component parent);
      super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
      p_h=producer::type_id::create("p_h",this);
      c_h=consumer::type_id::create("c_h",this);
    endfunction

    function void connect_phase(uvm_phase phase);
      p_h.pro_put_port.connect(c_h.con_put_exp);
    endfunction

    task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      #50;
      phase.drop_objection(this);
    endtask

    function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      uvm_top.print_topology(); // FOR PRINTING TOPOLOGY
      `uvm_info("top","THIS IS END_OF_ELABORATION PHASE IN TEST",UVM_MEDIUM);
    endfunction
  endclass

  initial begin
    run_test("top");
  end


endmodule
