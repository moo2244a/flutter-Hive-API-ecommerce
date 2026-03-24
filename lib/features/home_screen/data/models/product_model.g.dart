part of 'product_model.dart';

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 0;

  @override
  ProductModel read(BinaryReader reader) {
    return ProductModel(
      id: reader.readInt(),
      title: reader.readString(),
      description: reader.readString(),
      category: reader.readString(),
      price: reader.readDouble(),
      thumbnail: reader.readString(),
      images: reader.readList().cast<String>(),
      quantity: reader.readBool() ? reader.readInt() : null,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.description);
    writer.writeString(obj.category);
    writer.writeDouble(obj.price);
    writer.writeString(obj.thumbnail);
    writer.writeList(obj.images);
    if (obj.quantity != null) {
      writer.writeBool(true);
      writer.writeInt(obj.quantity!);
    } else {
      writer.writeBool(false);
    }
  }
}
