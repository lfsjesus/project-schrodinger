import 'package:flutter/material.dart';
import 'package:uni/view/common_widgets/generic_expansion_card.dart';
import 'package:uni/view/useful_info/widgets/text_components.dart';

class MultimediaCenterCard extends GenericExpansionCard {
  const MultimediaCenterCard({Key? key}) : super(key: key);

  @override
  Widget buildCardContent(BuildContext context) {
    return Column(
      children: <Container>[
        h1('Horário', context, initial: true),
        h2('Sala B123', context),
        infoText('9:00h - 12:30h | 14:30h - 17:00h', context),
        h1('Telefone', context),
        infoText('+351 225 081 466', context, link: 'tel:225 081 466'),
        h1('Email', context),
        infoText('imprimir@fe.up.pt', context,
            last: true, link: 'mailto:imprimir@fe.up.pt')
      ],
    );
  }

  @override
  String getTitle() => 'Centro de Multimédia';
}
