module top;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  `include "trans.sv"
  `include "tlm_monitor.sv"
  `include "tlm_rm.sv"
  `include "tlm_sb.sv"

  class tlm_analysis_top extends uvm_component;
    `uvm_component_utils(tlm_analysis_top)
    monitor m_h;
    ref_model rm_h;
    scoreboard sb_h;
    function new(string name="tlm_analysis_top", uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      m_h = monitor::type_id::create("m_h",this);
      rm_h = ref_model::type_id::create("rm_h",this);
      sb_h = scoreboard::type_id::create("sb_h",this);
    endfunction

    function void connect_phase(uvm_phase phase);
      m_h.mon_analysis_port.connect(sb_h.sb_analysis_imp);
      m_h.mon_analysis_port.connect(rm_h.rm_analysis_imp);
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      uvm_top.print_topology(); // FOR PRINTING TOPOLOGY
      //`uvm_info("top","THIS IS END_OF_ELABORATION PHASE IN TEST",UVM_MEDIUM);
    endfunction

    task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      #50;
      phase.drop_objection(this);
    endtask
  endclass

  initial begin
    run_test("tlm_analysis_top");
  end

endmodule
