import streamlit as st
import random
import csv
import os

options = [
    "apple",
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
    "apricot"
]


st.title("Preference Picker")

name = st.text_input("Enter your name:")
name = name.strip().lower()
if name:
    output_file = f"{name}_preferences.csv"

    # initialize file
    if not os.path.exists(output_file):
        with open(output_file, "w", newline="") as f:
            csv.writer(f).writerow(["option_a", "option_b", "chosen"])

    if "pair" not in st.session_state:
        st.session_state.pair = random.sample(options, 2)

    a, b = st.session_state.pair

    st.markdown("### Pick one:")
    col1, col2 = st.columns(2)

    def record_choice(choice):
        with open(output_file, "a", newline="") as f:
            csv.writer(f).writerow([a, b, choice])
        st.session_state.pair = random.sample(options, 2)
        st.rerun()

    if col1.button(a, use_container_width=True):
        record_choice(a)
    if col2.button(b, use_container_width=True):
        record_choice(b)
