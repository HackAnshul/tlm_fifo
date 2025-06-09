class ref_model extends uvm_component;
  trans trans_h;

  `uvm_component_utils(ref_model)
  uvm_analysis_imp #(trans,ref_model) rm_analysis_imp;

  function new(string name = "ref_model", uvm_component parent);
    super.new(name, parent);
    rm_analysis_imp = new("rm_analysis_imp", this);
  endfunction

  function void write(trans trans_h);
    `uvm_info("ref_model",$sformatf("trans_h = %p",trans_h),UVM_MEDIUM)
  endfunction

endclass
