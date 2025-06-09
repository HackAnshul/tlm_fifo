//generating data directly here, just for practice

class monitor2 extends uvm_component;
  //transaction class handle
  trans trans_h;

  `uvm_component_utils(monitor2)
  uvm_analysis_port #(trans) mon_analysis_port; //analysis port declaration

  function new(string name = "monitor2", uvm_component parent);
    super.new(name, parent);
    mon_analysis_port = new("mon_analysis_port", this);
  endfunction

  task run_phase(uvm_phase phase);
    repeat(5) begin
      trans_h = new();
      assert(trans_h.randomize());
      `uvm_info("monitor2",$sformatf("trans = %p",trans_h),UVM_MEDIUM);
      mon_analysis_port.write(trans_h);
      #1;
    end
  endtask

endclass
