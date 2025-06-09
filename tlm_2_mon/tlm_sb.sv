class scoreboard extends uvm_component;
  trans trans_h;

  `uvm_component_utils(scoreboard)
  uvm_analysis_imp #(trans,scoreboard) sb_analysis_imp;

  function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
    sb_analysis_imp = new("sb_analysis_imp", this);
  endfunction

  function void write(trans trans_h);
    `uvm_info("scoreboard",$sformatf("trans_h = %p",trans_h),UVM_MEDIUM)
  endfunction

endclass
