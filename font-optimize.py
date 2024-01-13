import base64

FONT = "NotoSansJP-Subset"

with open(f"{FONT}.txt", "w") as output_file:
    with open(f"{FONT}.woff2", "rb") as input_file:
        output_file.write(
            f"data:font/woff2;utf-8;base64,{base64.b64encode(input_file.read()).decode('utf-8')}"
        )

"""
You can now use it as follows:
<svg {...} >
    <style type="text/css">
        @font-face {
            font-family: Font-Name;
            src: url(...);
        }
    </style>
    <text font-family="Font-Name">
        some text
    </text>
</svg>
"""
