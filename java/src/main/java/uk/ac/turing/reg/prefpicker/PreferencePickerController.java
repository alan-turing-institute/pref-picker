package uk.ac.turing.reg.prefpicker;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class PreferencePickerController {

    @GetMapping("/preferencePicker")
    public String preferencePickerForm(Model model) {
        model.addAttribute("preferencePicker", new PreferencePicker());
        return "preferencePicker";
    }

    @PostMapping("/preferencePicker")
    public String preferencePickerSubmit(@ModelAttribute PreferencePicker preferencePicker, Model model) {
        model.addAttribute("preferencePicker", preferencePicker);
        return "result";
    }

}