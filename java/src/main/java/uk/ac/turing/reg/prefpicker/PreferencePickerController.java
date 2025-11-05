package uk.ac.turing.reg.prefpicker;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;


@Controller
public class PreferencePickerController {

    private final String[] options = {"apple",
            "banana",
            "orange",
            "grape",
            "strawberry",
            "mango",
            "pineapple",
            "kiwi",
            "blueberry",
            "pear",
            "peach",
            "cherry",
            "plum",
            "watermelon",
            "papaya",
            "raspberry",
            "blackberry",
            "coconut",
            "pomegranate",
            "apricot"};

    @GetMapping("/preferencePicker")
    public String preferencePickerForm(Model model) {

        List<String> randomisedOptions = Arrays.asList(options);
        Collections.shuffle(randomisedOptions);

        PreferencePicker preferencePicker = new PreferencePicker();
        preferencePicker.setFirstOption(randomisedOptions.get(0));
        preferencePicker.setSecondOption(randomisedOptions.get(1));

        model.addAttribute("preferencePicker", preferencePicker);

        return "preferencePicker";
    }

    @PostMapping("/preferencePicker")
    public String preferencePickerSubmit(@ModelAttribute PreferencePicker preferencePicker, Model model) {
        model.addAttribute("preferencePicker", preferencePicker);
        return "result";
    }

}